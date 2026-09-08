Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022100.outbound.protection.outlook.com [40.107.75.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF8B2BD587
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788834313; cv=fail; b=uFT6+i5H69pQqVcih/hLbP2DWJDvH4vxC2pzCkCzDr6G1DGHFyVFMAEIqgQz0fwwUVOnUCDTJ9XZzZ/2e/sefzlLW3VljYAir5MSO5Fkn2+0GuPagn+8Y9YfrowVvL2dl651bjThgXQiWfaQQyO95EJ0pgrZm1lUgu/K/TGw2Iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788834313; c=relaxed/simple;
	bh=3tDZl57T4YZg/PrH224pw78u0g2EH1134INZYp/efxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YsojFe4pUu7kcJJDZzOYER99I8nN+kmRNpBkjoSbvDv322H89sCon5eKde+sQiTU0EObrhTzsCIlAyScviZKEGTpHeTSfMvA98Gd7Jh0oYZJtBl7vzk2B/VD7VFkHqQ9KYeL4wl/YXMmLMyYp4JG2M9dnx3INYG9O5rUf3GVZt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com; spf=pass smtp.mailfrom=processmission.com; dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b=QnL7N7v/; arc=fail smtp.client-ip=40.107.75.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=processmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=processmission.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=processmission.com header.i=@processmission.com header.b="QnL7N7v/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWh8+EGrCyGQSbn3K9CiNGQlWjINF9dVHbExLXxELltbVFuYeI64uqqdnUnaTD/l1yGYEHsFYuS32QpdFCKa1ZDnZ8stJONQJhezsw2/55az1tPz6+RCcXQf4kFq461QQT0wgLMx9TDdjVRTh1YzDVBywcfh4eH+NgPxOO+by9b20SCYlbNdhXVIYS5OjMmBwIgl4yBDQaUxSkECB0Xr6oIGA662nDHLuEqA8i8ItV+BMo/g06WZ0Ioe4/QkJkI3zK0BO9Y10quTyrAfWdqiP1jDmZridFNR3NenQljrVXKMFnRRQs2JZAun/KOmR+4UAx0i7oQSO3raDUExTu/4zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTPJc6M1yxzKtmIvl9KnV317lLoyRoTowqUeQg/T+BQ=;
 b=f3V6ZTltpgj+kFgXYW8vlGK5uNP6kRLtWy/k0mqAmBK/i+v9BrOP3wMZPtRZLp1ajyE3Mtgy6GpgrxcwmYNjYIdlsZtXg4yxyYZQU7AaF9E83yI8xMYIe8BeaBZ4mLovd21ESzFmjRWgKvGu8s0VZQ0/aZ+etlyI3QEoSuSyPFKVC55m5R0h6eT8W9d3mq7jpWxvD/13LZUtABdq+UTqEEU9NJ8KlQw7+j/WuD1vSawL8SMsKH6IzR9RYSGyuJFmJZsxw4ZAmGi9ZERZm4qwvqmQSvEDDRmxbU4mCO6PTNuBBSpQImqO3o2HmgfX1mmsRtzq0O9Nr80qA2PwGk69Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=processmission.com; dmarc=pass action=none
 header.from=processmission.com; dkim=pass header.d=processmission.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=processmission.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTPJc6M1yxzKtmIvl9KnV317lLoyRoTowqUeQg/T+BQ=;
 b=QnL7N7v/JsORBTIGpdlDp3hDjLbuM/iFIf7+RyU3S9NV8VzSUXxHmMzI1NMxvjat0v1qPK6zZNpYTiMTLuVZeGEBMqYBYP9F/gR8T9YzI1vmr01MpwasMS0yt28a0qJ8uYBDLB10CDDJYNj0kqDVl12MmSE1aH6BsVGXiAj/jYQB340RSpN2sTOAyfpONEwkTPEhHsDVuOdZWDVk0Mt+z9F7LiC/HHv7A6qGMGC/DFoRREFPZwkx4lNczzNtAioylqajo6dbEgNz0Qt0o0np2/v1Ay7ys3Y6e/TY3X/Jtr7wgM2MLBZT6JCflGd6J8J286ObDmeseWf4ACwpt/NMdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=processmission.com;
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com (2603:1096:405:3d0::15)
 by TY0PR02MB6968.apcprd02.prod.outlook.com (2603:1096:405:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 02:25:07 +0000
Received: from TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934]) by TYNPR02MB9351.apcprd02.prod.outlook.com
 ([fe80::e5f3:5fb7:3d29:5934%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 02:25:07 +0000
Date: Tue, 8 Sep 2026 10:25:01 +0800
From: Chao Liu <chao.liu@processmission.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com, 
	imammedo@redhat.com, sunilvl@ventanamicro.com, jic23@kernel.org, pbonzini@redhat.com, 
	liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
	anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com, 
	junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 1/6] hw/riscv/virt: Add CXL support to the RISC-V virt
 machine
Message-ID: <ap9xqtWTwJzPbsjv@MacBook-Pro-4.local>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
 <20260907093735.2753-2-cp0613@linux.alibaba.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907093735.2753-2-cp0613@linux.alibaba.com>
X-ClientProxiedBy: PH7P220CA0040.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::24) To TYNPR02MB9351.apcprd02.prod.outlook.com
 (2603:1096:405:3d0::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYNPR02MB9351:EE_|TY0PR02MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 42549e7f-1355-40e8-0ecf-08df0d5065fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	woO8Ma0XiVZyMn0UwLZ3ubg5LdzEHoDDuQX1VDl9tx41/1n/znTH/RP4Peh7r6Klk6e4ukICDgkUa9IW9rBDtC13KMOR20ZGfZknsMDTcz72RTo8N29Oxh5Yu8pV3XB4NPmTGLAGyYTsjJjsq0V3JqN5R++aHlGT7JLGEzgV0RkDG49y58/gCfnvMd+61pT7+Xb3MLR78id0cEI+Uk07ciAsunqBHNsK7WVl9OfIRrRHz58pEu9mouvWoobaW0zfwC6Da4bg9DGVT4uMEOda4Hy4oQuxPi3XJVXfXi+Bks61YFFOPeodzX68vkjSva7+FHF9c6wKDkdSUmf6FET1ub3Wsc2B0OYKgOgwqZyfEHgfXCjy8n/MteutPTw+3NIS4LiNtevn8hrGJ2PjFx+2NXAEr5THSkB8qJhPhiadPRHzRtGQ7+sFdLvcYROxBvQKpGhUJsBRO+dvfViRSvDUXX3+tRj+PLX9lw5Fhajh3PMRGXIEeMQ5VmdFc1fC9Ng26k1TIvSd5o9/c5t5ZQffhHFoLq46ApcTS9t0ke4zJcSKgLRvTka1owZB+YTjSu8EBfjUt3J1gA+vNaZ52POy+oB7rABhNWApMH8+4ZbFQIorlWPGQokJiSCDGSGdtsVHcVQU3HrDc+LjnkXjISFMzs4DIQGSCMP0/SU/xKMY7g4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYNPR02MB9351.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9BqNBD8rvbKfHpUxZ9xBn/JcihdKuc8pJgpJyv8+HAEFN7RdiLEFkf5JK/Tl?=
 =?us-ascii?Q?wVLK/XXidjY4lFBkBHv0HQKgZ2AI9C7Tz8jQ7HwdXJ91pROH+rNSBkbhufZK?=
 =?us-ascii?Q?T4p7GUKX+SRBDS7orFx4SEmYQDikWTPqZKfgkzKtpauufdhAmAcCkJqiFg38?=
 =?us-ascii?Q?zKSDzUkbjvOqP9Bv2hx6usf2tVAHKghFEsg1JXgnbp4HGZTJ7I6XDbNHy4tr?=
 =?us-ascii?Q?shBfEyJsKhgwUTGdesONik2sMVpiDWy1PVM17bD3Fcla+bJ5JLCGp2RJm1k5?=
 =?us-ascii?Q?RuEAM3pLySWU8GzeGSnRk4grLkFMm/PjuT6y8Vw5TLpmgNhiQaiDnnXDeviy?=
 =?us-ascii?Q?rLMHDzihPHfEdGg+TKtur20jctHO3gGJXrDyKyNIlhbIgbk+u3I7kJLp41dw?=
 =?us-ascii?Q?hwAgOKztJVzCkvg7XLoHeUAOqnYXj36KffSmrZUHdtYLR77J8+fOvpw0CRdT?=
 =?us-ascii?Q?dhgmvOwCDb7+fep1vsogns0UGEUrhkunaateLKzxCRzQzA/XJL8OMVbbSaa+?=
 =?us-ascii?Q?nXmKta4MgIOpwJmqFzCT1ZOeOtZoCrC3PJDL/yBWJd0V2AIiC5ypZF99RDtg?=
 =?us-ascii?Q?tzutgZiH/hZguCgYVroGnxt/DIZ1B8605kBgoS1Y/uIDF/9Eflikc9fVzfeH?=
 =?us-ascii?Q?JKPT9RBkm67VXO1qZnPsYyLT3dn6o8kQUJGLqrD/hpuk1+76PRIN37o+TCcq?=
 =?us-ascii?Q?BK1GfgcxxV14wyPCWKqWjOAA5t8CRIq+JFmvziIycYsun2kz37J202exmPTy?=
 =?us-ascii?Q?LztGtZMkG8lwmjHAAfTPP8DBbuWlArLkAnQMeFyVUbwa3YLT88LrlJxOjYYU?=
 =?us-ascii?Q?Hwb9Jh+um+Sfjc3NiGIITbicPxFdnASJuXNKADlFBSN6oi18KMJAnnKZDJeK?=
 =?us-ascii?Q?yxOIuu35+FNKuatbfLnl9g/F4cOCFU32+T+KUMvYmI9NZBhVFp7aeQCRu5cw?=
 =?us-ascii?Q?XOt2fYSaHankHXM8U2SoTWfxWsqstR/JYh6s1bQWo2+qOplHyp8F6ntNPlN5?=
 =?us-ascii?Q?2XDjz+tEag4A7DcS80+Ji1yHF9QJ4wNMfdAtF7/vbs+4yUmMh3n1keqdZ6p3?=
 =?us-ascii?Q?zxwhsTLCCQfnAYwd2ajAxNyTshA71qDbBjlDyC3/KVekPs0f+QmMtlIB37yZ?=
 =?us-ascii?Q?I/qb674Z0rutzcLlz++rjzUlIpf25RJhTy/DOsXI5RSqOjrR3LDWyRFNGS9I?=
 =?us-ascii?Q?HvSP6KX47/kge/YCwV4/5MoPhLG4n+tOgMZ7+76UrD00j4YYfO4RbrP+HCe0?=
 =?us-ascii?Q?Or8XctWMlLzWPRz8tgRdWcvHBQYIMZrBc/NPHzIjGSrIqhxtDquq+mBb2mBD?=
 =?us-ascii?Q?GYKWc/7h0YT9BS18q/SBzoTLmy6NRTDN5ZbLxRuPE2xpmsVbmhG9hzxHGZ5Z?=
 =?us-ascii?Q?VtiTIbKhABoAsLFxNfkNo3b6WCwb4cAcnwWUUzuvMscn8Brh3SZa5O8p8+QH?=
 =?us-ascii?Q?ThbZFtr+dfHhBGFpD0iYT0lx0/t7v9QGPprNYZUmY5BX8yFKA0Zcw27rNdaJ?=
 =?us-ascii?Q?7VjUvBZy35D8hcyXLFtmJYUmch9yCThMbwvbuDq6Eh4DWi1TB+UHGaAqvDPZ?=
 =?us-ascii?Q?2WmrouiSekfoxw72uEcPSjAeDmsx5/kJl9zA/ATTz/7rRimg2CWqJN4D4uHc?=
 =?us-ascii?Q?A0Lj/QZwRYEaab/r3n9qJ/lhNIwVCpdZ42Ihlx4DpePe5hjgBDPUFvKxVeNd?=
 =?us-ascii?Q?HXsU7Qx4ytXn5T+HDVe5/qxCfO+6ZYzDK6Zwacrf68fvoY2axa/XTfo+whI0?=
 =?us-ascii?Q?P4Yob2zdFjlCa2JO66EoxjmLqIkNp6w=3D?=
X-OriginatorOrg: processmission.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42549e7f-1355-40e8-0ecf-08df0d5065fb
X-MS-Exchange-CrossTenant-AuthSource: TYNPR02MB9351.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 02:25:06.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e0544bf7-9765-4630-ab69-0b266dc2169c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkxLpS2YDEe4kq7L5rpAoQ/mH1q1ELwGvOx4rnfJ8mzDWx1/scXQs4EJsohDqlnsvITE7WAT4ShXUDwsWE51N32kxMQAhtr00haghhIFu0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB6968

On Mon, Sep 07, 2026 at 05:37:28PM +0800, Chen Pei wrote:
> Enable CXL support on the RISC-V virt machine following the same
> approach used by the ARM virt machine:
> - Add PXB and ACPI_CXL Kconfig selections
> - Add CXLState and PCIBus pointer to RISCVVirtState
> - Register CXL machine properties via cxl_machine_init()
> - Create CXL host register region above the PCIe high MMIO region
> - Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
>   machine_done time
> - Map Fixed Memory Windows above the CXL host register region
> - Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>

Thanks,
Chao

> ---
>  hw/riscv/Kconfig           |  2 ++
>  hw/riscv/virt-acpi-build.c | 20 ++++++++++++++++
>  hw/riscv/virt.c            | 47 ++++++++++++++++++++++++++++++++++----
>  include/hw/riscv/virt.h    |  3 +++
>  4 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..c2f8c5d2da 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -66,8 +66,10 @@ config RISCV_VIRT
>      select VIRTIO_MMIO
>      select FW_CFG_DMA
>      select PLATFORM_BUS
> +    select PXB
>      select ACPI
>      select ACPI_PCI
> +    select ACPI_CXL
>  
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8e516ec114..2be8c6d572 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -29,12 +29,16 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/pci.h"
>  #include "hw/acpi/utils.h"
> +#include "hw/acpi/cxl.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/virtio/virtio-acpi.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>  #include "kvm/kvm_riscv.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> @@ -518,6 +522,17 @@ static void build_dsdt(GArray *table_data,
>          acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>      }
>  
> +    if (s->cxl_devices_state.is_enabled) {
> +        Aml *cxl_dev = aml_device("CXLM");
> +        aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +        Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0B)));
> +        aml_append(cxl_dev, method);
> +        build_cxl_dsm_method(cxl_dev);
> +
> +        aml_append(scope, cxl_dev);
> +    }
> +
>      aml_append(dsdt, scope);
>  
>      /* copy AML table into ACPI tables blob and patch header there */
> @@ -925,6 +940,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>                     s->oem_table_id);
>      }
>  
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
> +                       s->oem_id, s->oem_table_id, &s->cxl_devices_state);
> +    }
> +
>      if (ms->numa_state->num_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, s);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f3a1cc5ba3..70090ca70a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -56,6 +56,8 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
> @@ -540,6 +542,29 @@ static void create_fdt(RISCVVirtState *s)
>      create_fdt_pmu(s);
>  }
>  
> +static void cxl_host_state_init(RISCVVirtState *s)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &s->cxl_devices_state.host_mr;
> +    hwaddr base;
> +
> +    if (!s->cxl_devices_state.is_enabled) {
> +        return;
> +    }
> +
> +    base = virt_high_pcie_memmap.base + virt_high_pcie_memmap.size;
> +    base = ROUND_UP(base, 64 * KiB);
> +
> +    memory_region_init(mr, OBJECT(s), "cxl_host_reg", 64 * KiB * 16);
> +    memory_region_add_subregion(sysmem, base, mr);
> +
> +    /* Map the Fixed Memory Windows above the CXL host register region. */
> +    base += memory_region_size(mr);
> +    base = ROUND_UP(base, 256 * MiB);
> +    cxl_fmws_set_memmap(base, UINT64_MAX);
> +    cxl_fmws_update_mmio();
> +}
> +
>  static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
>      FWCfgState *fw_cfg;
> @@ -625,6 +650,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
>      BlockBackend *pflash_blk0;
>      RISCVBootInfo boot_info;
>  
> +    cxl_hook_up_pxb_registers(s->pci_bus, &s->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
> +
>      /*
>       * An user provided dtb must include everything, including
>       * dynamic sysbus devices. Our FDT needs to be finalized.
> @@ -716,6 +748,7 @@ static void virt_machine_init(MachineState *machine)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> +    DeviceState *gpex_dev;
>      int i, base_hartid, hart_count;
>      int socket_count = riscv_socket_count(machine);
>  
> @@ -871,6 +904,8 @@ static void virt_machine_init(MachineState *machine)
>              ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
>      }
>  
> +    cxl_host_state_init(s);
> +
>      /* register system main memory (actual RAM) */
>      memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
>                                  machine->ram);
> @@ -898,10 +933,12 @@ static void virt_machine_init(MachineState *machine)
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
>  
> -    riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> -                   &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
> -                   &virt_high_pcie_memmap, &s->memmap[VIRT_PCIE_PIO],
> -                   PCIE_IRQ);
> +    gpex_dev = riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> +                                    &s->memmap[VIRT_PCIE_ECAM],
> +                                    &s->memmap[VIRT_PCIE_MMIO],
> +                                    &virt_high_pcie_memmap,
> +                                    &s->memmap[VIRT_PCIE_PIO], PCIE_IRQ);
> +    s->pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
>  
>      s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
>          &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
> @@ -972,6 +1009,8 @@ static void virt_machine_instance_init(Object *obj)
>      s->acpi = ON_OFF_AUTO_AUTO;
>      s->iommu_sys = ON_OFF_AUTO_AUTO;
>      s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
> +
> +    cxl_machine_init(obj, &s->cxl_devices_state);
>  }
>  
>  static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e516898f9a..a7b74d10c6 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -24,6 +24,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/block/flash.h"
>  #include "hw/intc/riscv_imsic.h"
> +#include "hw/cxl/cxl.h"
>  
>  #define VIRT_CPUS_MAX_BITS             9
>  #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -66,6 +67,8 @@ struct RISCVVirtState {
>      OnOffAuto iommu_sys;
>      uint16_t pci_iommu_bdf;
>      uint16_t num_sources;
> +    CXLState cxl_devices_state;
> +    PCIBus *pci_bus;
>  };
>  
>  enum {
> -- 
> 2.50.1
> 
