Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A38F4A
	for <linux-cxl@vger.kernel.org>; Fri, 25 Jul 2025 14:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753455259; cv=none; b=Z4yQ7NN/7vdmIEU7tkQMgDUQ7oJ/QsuXf2+Kc+v/+MwKD5/RXXXbyihW9hqK18n/AeecT/LjoWhjIXJo/XH15dtPiSQs8KX8A1AgRGxYCt9Q/lKQi99aSdJe+7E6/GN6L4I/SsUATb3Iof8IJr8mmjSR95sxc6hqr/e8qYmM3/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753455259; c=relaxed/simple;
	bh=4Z2vzEp59Ro7GqJ3px9oY8QbfpVbKlZ2G/5cHSzaKnQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOtmW75hTpOnFVJXn1ZW5t15BBCK8yuiTmK75uvVeDvy3lMTghqphTHYIGFR5QjqJCwvHKsAKuJTgwOjfXdSLJqiaMShCQtOFmnKqqiAerla9oLmp5eP1urZ6wfHN5XO0bHWCSxeDp5Q5zTNrljaYahIMB17L9yEnsKwG01QL3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bpW7L2Txmz6L5C8;
	Fri, 25 Jul 2025 22:52:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 244611400DC;
	Fri, 25 Jul 2025 22:54:10 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Jul
 2025 16:54:09 +0200
Date: Fri, 25 Jul 2025 15:54:08 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
	<linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<vishak.g@samsung.com>, <krish.reddy@samsung.com>,
	<a.manzanares@samsung.com>, <alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v2 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250725155408.000053db@huawei.com>
In-Reply-To: <20250710144338.2839512-2-arpit1.kumar@samsung.com>
References: <20250710144338.2839512-1-arpit1.kumar@samsung.com>
	<CGME20250710144354epcas5p46a083b743de04f5849e3449a4d9dfe87@epcas5p4.samsung.com>
	<20250710144338.2839512-2-arpit1.kumar@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Jul 2025 20:13:37 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> -Storing physical ports info during enumeration.
> -Refactored changes using physical ports info for
>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
>  (Opcode 5101h) physical switch FM-API command set.
> 
> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Hi Arpit,

Sorry it took me a while to get to this. I've pretty much forgotten
the v1, so taking a full fresh look.


Various minor comments inline.

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c                | 229 ++++++++++++----------
>  include/hw/cxl/cxl_device.h               |  82 ++++++++
>  include/hw/pci-bridge/cxl_upstream_port.h |   4 +
>  3 files changed, 207 insertions(+), 108 deletions(-)
> 


> @@ -620,69 +585,20 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -    /* For success there should be a match for each requested */
> -    out->num_ports = in->num_ports;
> +    if (in->num_ports > pp->pports.num_ports) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
>  
> +    out->num_ports = in->num_ports;
>      for (i = 0; i < in->num_ports; i++) {
> -        struct cxl_fmapi_port_state_info_block *port;
> -        /* First try to match on downstream port */
> -        PCIDevice *port_dev;
> -        uint16_t lnkcap, lnkcap2, lnksta;
> -
> -        port = &out->ports[i];
> -
> -        port_dev = pcie_find_port_by_pn(bus, in->ports[i]);
> -        if (port_dev) { /* DSP */
> -            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
> -                ->devices[0];  
> -            port->config_state = 3;
> -            if (ds_dev) {
> -                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
> -                    port->connected_device_type = 5; /* Assume MLD for now */
> -                } else {
> -                    port->connected_device_type = 1;
> -                }
> -            } else {
> -                port->connected_device_type = 0;
> -            }
> -            port->supported_ld_count = 3;
> -        } else if (usp->port == in->ports[i]) { /* USP */
> -            port_dev = PCI_DEVICE(usp);
> -            port->config_state = 4;
> -            port->connected_device_type = 0;
> -        } else {
> +        int pn = in->ports[i];

Blank line after declarations.

> +        if (pp->pports.pport_info[pn].port_id != pn) {
>              return CXL_MBOX_INVALID_INPUT;
> +        } else {

Returned in the if, so no need for an else here.

> +            memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
> +                   sizeof(struct cxl_phy_port_info));
>          }

>  
> +static CXLRetCode cxl_set_port_type(CXLUpstreamPort *ports, int pnum,
> +                                    CXLCCI *cci)
> +{
> +    uint16_t lnkcap, lnkcap2, lnksta;
> +    PCIBus *bus;
> +    PCIDevice *port_dev;
> +    PCIEPort *usp = PCIE_PORT(cci->d);
> +
> +    if (usp->port == pnum) {
> +        port_dev = PCI_DEVICE(usp);
> +        ports->pports.pport_info[pnum].current_port_config_state =
> +            CXL_PORT_CONFIG_STATE_USP;
> +        ports->pports.pport_info[pnum].connected_device_type = NO_DEVICE_DETECTED;

Use local variables for connected_device_type and supported_ld_count;
Then...

> +    } else {
> +        bus = &PCI_BRIDGE(cci->d)->sec_bus;
> +        port_dev = pcie_find_port_by_pn(bus, pnum);
> +        if (port_dev) { /* DSP */
> +            PCIDevice *ds_dev = pci_bridge_get_sec_bus(PCI_BRIDGE(port_dev))
> +                ->devices[0];
> +            ports->pports.pport_info[pnum].current_port_config_state =
> +               CXL_PORT_CONFIG_STATE_DSP;
> +            if (ds_dev) {
> +                if (object_dynamic_cast(OBJECT(ds_dev), TYPE_CXL_TYPE3)) {
> +                    /* To-do: controllable */
> +                    ports->pports.pport_info[pnum].connected_device_type =
> +                        CXL_TYPE_3_SLD;
> +                } else {
> +                    ports->pports.pport_info[pnum].connected_device_type = PCIE_DEVICE;
> +                }
> +            } else {
> +                ports->pports.pport_info[pnum].connected_device_type = NO_DEVICE_DETECTED;
> +            }
> +            ports->pports.pport_info[pnum].supported_ld_count = 3;
> +        } else {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    }
> +
> +    if (!port_dev->exp.exp_cap) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +    lnksta = port_dev->config_read(port_dev,
> +                                   port_dev->exp.exp_cap + PCI_EXP_LNKSTA,
> +                                   sizeof(lnksta));
> +    lnkcap = port_dev->config_read(port_dev,
> +                                   port_dev->exp.exp_cap + PCI_EXP_LNKCAP,
> +                                   sizeof(lnkcap));
> +    lnkcap2 = port_dev->config_read(port_dev,
> +                                    port_dev->exp.exp_cap + PCI_EXP_LNKCAP2,
> +                                    sizeof(lnkcap2));
> +
Can fill this whole thing with
    ports->pports.pport_info[pnum] = (CXLPhysicalPortInfo) {
       .connected_device_type = connected_device_type,
       .supported_ld_count = supported_ld_count,
       .max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4,
etc.
   };
> +    ports->pports.pport_info[pnum].max_link_width = (lnkcap & PCI_EXP_LNKCAP_MLW) >> 4;
> +    ports->pports.pport_info[pnum].negotiated_link_width =
> +        (lnksta & PCI_EXP_LNKSTA_NLW) >> 4;
> +    ports->pports.pport_info[pnum].supported_link_speeds_vector = (lnkcap2 & 0xFE) >> 1;
> +    ports->pports.pport_info[pnum].max_link_speed = lnkcap & PCI_EXP_LNKCAP_SLS;
> +    ports->pports.pport_info[pnum].current_link_speed = lnksta & PCI_EXP_LNKSTA_CLS;
> +
> +    ports->pports.pport_info[pnum].port_id = pnum;
> +    ports->pports.active_port_bitmask[pnum / 8] |= (1 << pnum % 8);
> +    ports->pports.pport_info[pnum].ltssm_state = LTSSM_L2;
> +    ports->pports.pport_info[pnum].first_negotiated_lane_num = 0;
> +    ports->pports.pport_info[pnum].link_state_flags = 0;
> +    ports->pports.pport_info[pnum].supported_cxl_modes = CXL_256B_FLIT_CAPABLE;
> +    ports->pports.pport_info[pnum].connected_device_mode = STANDARD_256B_FLIT_MODE;
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
> +static void cxl_set_dsp_port(PCIBus *bus, PCIDevice *dev, void *opaque)
> +{
> +    CXLCCI *cci = (CXLCCI *)opaque;
> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_DSP)) {
> +        uint8_t phy_port_num = PCIE_PORT(dev)->port;

Does the local variable add anything over

        cxl_set_port_type(pp, PCIE_PORT(dev)->port, cci);

> +        cxl_set_port_type(pp, phy_port_num, cci);
> +    }
> +}
> +
> +static CXLRetCode cxl_set_phy_port_info(CXLCCI *cci)
> +{
> +    PCIEPort *usp = PCIE_PORT(cci->d);
> +    PCIBus *bus = &PCI_BRIDGE(cci->d)->sec_bus;
> +    CXLUpstreamPort *pp = CXL_USP(cci->d);
> +    int num_phys_ports = pcie_count_ds_ports(bus) + 1;
> +    pp->pports.num_ports = num_phys_ports;
> +    uint8_t phy_port_num =  usp->port;

Seems to be an extra space after =

> +
> +    cxl_set_port_type(pp, phy_port_num, cci); /* USP */
> +    pci_for_each_device_under_bus(bus, cxl_set_dsp_port, cci); /* DSP */
> +
> +    return CXL_MBOX_SUCCESS;
> +}

> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ca515cab13..1fa6cf7536 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -127,6 +127,88 @@
>                    CXL_NUM_CHMU_INSTANCES * (1 << 16),                   \
>                    (1 << 16))
>  
> +#define CXL_MAX_PHY_PORTS 256
> +
> +#define LINK_STATE_FLAG_LANE_REVERSED    BIT(0)
> +#define LINK_STATE_FLAG_PERST_ASSERTED   BIT(1)
> +#define LINK_STATE_FLAG_PRSNT            BIT(2)
> +#define LINK_STATE_FLAG_POWER_OFF        BIT(3)
> +
> +/* physical port control info - CXL r3.2 table 7-19 */
> +#define CXL_PORT_CONFIG_STATE_DISABLED           0x0
> +#define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
> +#define CXL_PORT_CONFIG_STATE_UNBIND_IN_PROGRESS 0x2
> +#define CXL_PORT_CONFIG_STATE_DSP                0x3
> +#define CXL_PORT_CONFIG_STATE_USP                0x4
> +#define CXL_PORT_CONFIG_STATE_FABRIC_PORT        0x5
> +#define CXL_PORT_CONFIG_STATE_INVALID_PORT_ID    0xF
> +
> +typedef enum {
> +    NOT_CXL_OR_DISCONNECTED = 0x00,
> +    RCD_MODE = 0x01,
> +    CXL_68B_FLIT_AND_VH_MODE = 0x02,
> +    STANDARD_256B_FLIT_MODE = 0x03,
> +    CXL_LATENCY_OPTIMIZED_256B_FLIT_MODE = 0x04,
> +    PBR_MODE = 0x05
> +} connected_device_mode;
> +
> +typedef enum {
> +    NO_DEVICE_DETECTED = 0,
> +    PCIE_DEVICE = 1,
> +    CXL_TYPE_1_DEVICE = 2,
> +    CXL_TYPE_2_DEVICE_OR_HBR_SWITCH = 3,
> +    CXL_TYPE_3_SLD = 4,
> +    CXL_TYPE_3_MLD = 5,
> +    PBR_COMPONENT = 6
> +} connected_device_type;
> +
> +typedef enum {
> +    CXL_RCD_MODE = 0x00,
> +    CXL_68B_FLIT_AND_VH_CAPABLE = 0x01,
> +    CXL_256B_FLIT_CAPABLE = 0x02,
> +    CXL_LATENCY_OPTIMIZED_256B_FLIT = 0x03,
> +    CXL_PBR_CAPABLE = 0x04
> +} supported_cxl_modes;

Similar to below. Enums make sense when we actually
use the type.  Apply this comment to all the others above.


> +
> +typedef enum {
> +    LTSSM_DETECT = 0x00,
> +    LTSSM_POLLING = 0x01,
> +    LTSSM_CONFIGURATION = 0x02,
> +    LTSSM_RECOVERY = 0x03,
> +    LTSSM_L0 = 0x04,
> +    LTSSM_L0S = 0x05,
> +    LTSSM_L1 = 0x06,
> +    LTSSM_L2 = 0x07,
> +    LTSSM_DISABLED = 0x08,
> +    LTSSM_LOOPBACK = 0x09,
> +    LTSSM_HOT_RESET = 0x0A
> +} LTSSM_State;

No Underscore.  Qemu enum type naming is CammelCase
However I'm not a fan of an enum for this stuff unless we
actually use that type to enforce something.

I'd just use a set of defines.  However they'll want
some suitable prefix.  They are PCI terms but I can't
find a similar assignment of values in the PCI spec, so
CXL_LTSMM_x I think.



> +
> +/* CXL r3.2 Table 7-19: Port Info */
> +struct cxl_phy_port_info {
typedef CXLPhyPortInfo {
} CXLPhyPortInfo;
See comment on QEMU use of typedefs below. 

We aren't always doing this right in the CXL code, but lets not make it worse!
> +    uint8_t port_id;
> +    uint8_t current_port_config_state;
> +    uint8_t connected_device_mode;
> +    uint8_t rsv1;
> +    uint8_t connected_device_type;
> +    uint8_t supported_cxl_modes;
> +    uint8_t max_link_width;
> +    uint8_t negotiated_link_width;
> +    uint8_t supported_link_speeds_vector;
> +    uint8_t max_link_speed;
> +    uint8_t current_link_speed;
> +    uint8_t ltssm_state;
> +    uint8_t first_negotiated_lane_num;
> +    uint16_t link_state_flags;
> +    uint8_t supported_ld_count;
> +} QEMU_PACKED;
> +
> +struct phy_port {

Should prefix this I think and it looks to be plural so
struct cxl_phy_ports maybe?

Actually given it's exposed outside one file we should follow
QEMU naming style and a typedef.
https://qemu-project.gitlab.io/qemu/devel/style.html#typedefs

CXLPhysicalPorts perhaps? 

Or thinking more, do we need this definition at all as it
only gets instantiated in CXLUpstreamPort
See below.

> +    uint8_t num_ports;
> +    uint8_t active_port_bitmask[0x20];

Can we derive that 0x20 ?  I'm guessing it's CXL_MAX_PHY_PORTS / BITS_PER_BYTE

> +    struct cxl_phy_port_info pport_info[CXL_MAX_PHY_PORTS];
> +};
> +
>  /* CXL r3.1 Table 8-34: Command Return Codes */
>  typedef enum {
>      CXL_MBOX_SUCCESS = 0x0,
> diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
> index db1dfb6afd..bcd3002cf8 100644
> --- a/include/hw/pci-bridge/cxl_upstream_port.h
> +++ b/include/hw/pci-bridge/cxl_upstream_port.h
> @@ -4,6 +4,7 @@
>  #include "hw/pci/pcie.h"
>  #include "hw/pci/pcie_port.h"
>  #include "hw/cxl/cxl.h"
> +#include "include/hw/cxl/cxl_device.h"
>  
>  typedef struct CXLUpstreamPort {
>      /*< private >*/
> @@ -23,6 +24,9 @@ typedef struct CXLUpstreamPort {
>  
>      DOECap doe_cdat;
>      uint64_t sn;
> +
> +    /*< physical ports information >*/
> +    struct phy_port pports;

No need for type I think.
    struct {
        uint8_t num;
        uint8_t active_bitmask[CXL_MAX_PHY_PORTS / BITS_PER_BYTE];
        CXLPhyPortInto info;
    } pports;

As they all only exists as part of pports, no need say they are phy
ports related in the parameter names.

>  } CXLUpstreamPort;
>  
>  #endif /* CXL_SUP_H */

