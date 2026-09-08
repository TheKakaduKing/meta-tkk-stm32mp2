# Disable Power Domain support in OP-TEE SCP firmware.
# CFG_SCPFW_MOD_POWER_DOMAIN / CFG_SCPFW_MOD_SCMI_POWER_DOMAIN / CFG_SCPFW_MOD_STM32_PD
# are hard-forced to "y" upstream in conf-optee-stm32mp2.mk, which causes an
# fwk_trap() call inside fwk_module.c, rooting in not having a single "power-domains" node
# in the OPTEE device tree (Caused by deactivating gpu node etc.). 
# fwk_module calls init function of the mod_power_domain module,
# which then checks if the device count (power domain count) is ==0. If so, error is returned
# and runs into trap in the desc->init check in fwk_module_initlialize function.
# Implies --> deactivate all 3 power domain modules, because we have no consumer for it (only one was the gpu)

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-disable-power-domains.patch"
