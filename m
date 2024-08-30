Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A63D17B516
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013905; cv=none; b=ElXEQM0UfQPibD6E/kYKX6qxw+JcHWMTmzRBvWoTsYAm+pg4US4eZ+XWwF0Yxq+AMV60K3eEudZxlakOtHv2pWWu3mdqfuqABjmC4JwGQYuy5QOPZYqauA2nt8Kn35djfRMXBcPFmSeUwYJd0XfnuA81iL52I7a+ie2qB8BcYJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013905; c=relaxed/simple;
	bh=AMy0kSEjNT+b6GqntrMQqJNlyQsGswoLakNcn5ilc6Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QMJCtBYaaDWHh7WyTsLaIXIJkESmpb/QULxIgGxrnuNd9AV3ivnm+x6/XT4Bupm2R8oT46VnZZDOvG0ZLBwgT7iPsqMEbrDTgWiCsN6rGejXt1bYMncrzWcWR9Z17m6uh9gLsjqUECD4F5dhva3yrBB5C8pQSja2MKaNb28bRP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwDrN2W7nz6J7t2;
	Fri, 30 Aug 2024 18:28:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6560E140155;
	Fri, 30 Aug 2024 18:31:39 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 11:31:38 +0100
Date: Fri, 30 Aug 2024 11:31:38 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
	<peter.maydell@linaro.org>, <devel@edk2.groups.io>, <qemu-devel@nongnu.org>,
	<linux-cxl@vger.kernel.org>, <chenbaozi@phytium.com.cn>,
	<wangyinfeng@phytium.com.cn>, <shuyiqi@phytium.com.cn>
Subject: Re: [RFC PATCH edk2-platforms 2/2] SbsaQemu: AcpiTables: Add CEDT
 Table
Message-ID: <20240830113138.00005149@Huawei.com>
In-Reply-To: <20240830031545.548789-3-wangyuquan1236@phytium.com.cn>
References: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
	<20240830031545.548789-3-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 11:15:45 +0800
Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:

> Provide CXL Early Discovery Table that describes the static CXL
> Platform Components of sbsa-ref.
> 
> This adds a static CXL Host Bridge structure and a CXL Fixed Memory
> Window structure which are implemented as two independent space on
> sbsa-ref: [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW].
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
A few superficial comments.

I'd love to see a dump of iasl -d for this table in the commit message.
That's much easier to sanity check for spec compliance than reading
the code that creates it.

Jonathan

> ---
>  .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  6 +-
>  Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    | 70 +++++++++++++++++++
>  Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  7 ++
>  3 files changed, 82 insertions(+), 1 deletion(-)
>  create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
> 
> diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
> index b4d5aa807bd9..f39b06d708d5 100644
> --- a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
> +++ b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
> @@ -21,7 +21,7 @@
>    Fadt.aslc
>    Mcfg.aslc
>    Spcr.aslc
> -
> +  Cedt.aslc
Fix up to keep the white space. Also this seems to be alphabetical
order so probably should stick to that.

>  [Packages]
>    ArmPlatformPkg/ArmPlatformPkg.dec
>    ArmPkg/ArmPkg.dec
> @@ -78,6 +78,10 @@
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit
>  
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize
> +
>    gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase
>  
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPlatformAhciBase
> diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
> new file mode 100644
> index 000000000000..66c9dc8858bc
> --- /dev/null
> +++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
> @@ -0,0 +1,70 @@
> +/** @file
> +*  CXL Early Discovery Table (CEDT)
> +*
> +*  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
> +*
> +**/
> +
> +#include <IndustryStandard/CXLEarlyDiscoveryTable.h>
> +#include <IndustryStandard/Acpi64.h>
> +#include <IndustryStandard/SbsaQemuAcpi.h>
> +
> +#pragma pack(1)
> +
> +typedef struct
> +{
> +  EFI_ACPI_6_4_CXL_Early_Discovery_TABLE           Header;
> +  EFI_ACPI_6_4_CXL_Host_Bridge_Structure           Chbs;
> +  EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure   Cfmws;
> +} SBSA_REF_CEDT;
> +
> +
> +SBSA_REF_CEDT Cedt =
> +{
> +  // EFI_ACPI_6_4_CXL_Early_Discovery_TABLE(Header)
> +  {
> +     SBSAQEMU_ACPI_HEADER  // EFI_ACPI_DESCRIPTION_HEADER
> +     (
> +       EFI_ACPI_6_4_CXL_EARLY_DISCOVERY_TABLE_SIGNATURE,
> +       SBSA_REF_CEDT,
> +       EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01
> +     ),
> +  },
> +  // EFI_ACPI_6_4_CXL_Host_Bridge_Structure
> +  {
> +    // EFI_ACPI_6_4_CEDT_Structure
> +    {
> +        EFI_ACPI_CEDT_TYPE_CHBS,                                 // Type
> +        0,                                                       // Reserved
> +        sizeof (EFI_ACPI_6_4_CXL_Host_Bridge_Structure),         // Length
> +    },
> +    FixedPcdGet32 (PcdCxlBusMin),          // UID
> +    0x1,                                   // CXLVersion
> +    0,                                     // Reserved
> +    FixedPcdGet32 (PcdChbcrBase),          // CHBCR Base
> +    0X10000,                               // Length
> +  },
> +  // EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure
> +  {
> +    // EFI_ACPI_6_4_CEDT_Structure
> +    {
> +        EFI_ACPI_CEDT_TYPE_CFMWS,                                // Type
> +        0,                                                       // Reserved
> +        sizeof (EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure), // Length
> +    },
> +    0,                                     // Reserved
> +    FixedPcdGet32 (PcdCfmwsBase),          // BaseHPA
> +    FixedPcdGet32 (PcdCfmwsSize),          // WindowSize
> +    0,                                     // InterleaveMembers
> +    0,                                     // InterleaveArithmetic
> +    0,                                     // Reserved1
> +    0,                                     // Granularity
> +    0xF,                                   // Restrictions
> +    0,                                     // QtgId

You'll need to implement the QTG DSM or I think the kernel will still moan at you.


> +    FixedPcdGet32 (PcdCxlBusMin),          // FirstTarget
> +  }
> +};
> +
> +#pragma pack ()
> +
> +VOID* CONST ReferenceAcpiTable = &Cedt;
> diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
> index 7d8c7997160b..dff838315d06 100644
> --- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
> +++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
> @@ -65,6 +65,13 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|254|UINT32|0x00000019
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x00000020
>  
> +  # PCDs complementing base address for CXL CHBCR (CXL Host Bridge Component Registers)
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase|0x60120000|UINT64|0x00000021
> +
> +  # CXL Fixed Memory Window

I'd add an index from the start just to make this easier to extend.
PcdCFwms0Base perhaps?

> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase|0xA0000000000|UINT64|0x00000022
> +  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize|0x10000000000|UINT64|0x00000023
> +
>  [PcdsDynamic.common]
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
>    gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemSerialNumber|L""|VOID*|0x00000111

