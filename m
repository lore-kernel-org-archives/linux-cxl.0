Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF38E2343D2
	for <linux-cxl@vger.kernel.org>; Mon,  3 Mar 2025 20:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741034352; cv=fail; b=C+1phLWvb4iDc0UD5NSJw2jXPzvo6dPCmHGX24doT7xoC556NDM4MssBAYv2WDBh5Dz0dC41PNyvI+A5nOCfY7G+zKn+fFS58MRDLP1BQKLJH4dJ0MlPGn78vJqGyQloKk3or5Df66TC88fP3Oe3ha7BFgcc0d82h84skXtnTtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741034352; c=relaxed/simple;
	bh=4K6M21LTDW/Pxw+KyuusUaOB5xCuMzaOysR4kcJ5shI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ehI2WUQR6F674C2iNvJUwougpxZ2hxh8l43v54HVrw7/0PfjslAjbUOBw3DHoxxDjuMz8bXwJ9/EuERKxywgTNA24A/bo9Q6GalblCvfVgnb0QG+vtGPrjS1j9SphyEBsh4CMQ8ZGDWrLao1gF62KJNDSA3eSa8X7GunC90R4QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t5HM61Wg; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t5HM61Wg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YqxexSmul0kmNGg6pj7ZrTr6tzy4GvOx0Jw7DKvglP3SavtQnLkyDPyisiL6cRzXsg52kghFcFvxlary2JyyoiK/el/6WtEDTjS8en4/qi9qS6KMF3FrefByHXy3Wd7NrFsB6BgsQTWtYQQQ5N8lmDgf/6us+amJ+GMXl0P4G/mDZW2SE4kb+7rB6Ncs25xKVJHBvMPZBb0rQeI5surqeQfFrPNSF0PEztjza8nSW3ZoQWvYH7IZUQp93SW8oUIArFJz8K8joYWMQXI9WPiXjv/OCTpBQ/XFpB6mDOfqiOTmy4SSNog0nxRjpUXOP3oCHKBzrl/HV7DDVDTGH8KnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgXu5O+usI85WbRZ3HJ5ry8R2o0slCWrUsBkg0rpTKE=;
 b=NNnTsk/ngptlTZRfmoB2d/wIBMyP1SCLziQQnTJwhsnrb3mREQLINEteb2C8soH2iRgSgr9lL8k4nfq7QV/QCU+fEdOmP2hufjF1FyN4MWJXagV9jIwhxrtVAokrBSGNWiOXYhI2Fx7ipoZM9lnR2B9eo4ShXPqDyGM0Pgt5ynDpIwPlIdO+0rBv/2rJkqoOiAz0YOlBwd6HVFaorJQQ3Ctka5kk5Ezli0ZRuI0IHD9EQyQJfX+xB+CsmuXv99hHU8clgR1/SeFAgCwsEmPynSfJwMaykMF/w7V5bEWv2zcg75Gsr91+SQCu1gZE/KuHZmHWOolC1CT97XwAPlKzVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgXu5O+usI85WbRZ3HJ5ry8R2o0slCWrUsBkg0rpTKE=;
 b=t5HM61WgEIEecd2flDvdag8mKmkzBCye4+svTJrGBdzNEKFOcgnPkwBfYzQtGl40AYijdu+mSA5wWfeXpRsYMxkAxWz4dL911TaD2BgD04g6xfAeNPk2woEX4SNKUjYtItZwRAcC3vKO8enKU3fGJ8GDCnGOsGpc4HMHgikAHhU=
Received: from MN2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:208:134::23)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 20:39:07 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:134:cafe::66) by MN2PR16CA0010.outlook.office365.com
 (2603:10b6:208:134::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.24 via Frontend Transport; Mon,
 3 Mar 2025 20:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 20:39:06 +0000
Received: from [10.236.179.218] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 14:39:05 -0600
Message-ID: <602d20fb-ab1b-41cd-9f51-98ca690b18c8@amd.com>
Date: Mon, 3 Mar 2025 14:39:04 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC type cxl initialization 1/2] cxl: add type2 device basic
 support
To: <alejandro.lucero-palau@amd.com>
CC: Alejandro Lucero <alucerop@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>
References: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
 <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250220200041.3891165-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c9579d-e54e-41a5-1eed-08dd5a93718d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2pqRnBnVEsrZVhNaWFtT3VNWFJQa0g1dXE1MUNjM09iZENCQ0pZblZlVXdu?=
 =?utf-8?B?UDAyL285Ty9Sb0phYW1WOTdsQWNZVUJQczdMN3MxR2grNWNHQjZ5cFF1cWRJ?=
 =?utf-8?B?WjRDV3BmZkNOYXovWGExYnRmWm4yTzlINHQ4TmJsNlpWNmhjZUROSFFLVU9i?=
 =?utf-8?B?Q0RLQW1wWGd3bG9yKzRWZ2NFK0Q0ZnlOcU1ETXg4enZxMVhMSVFKSHRYcGt6?=
 =?utf-8?B?cmxJNFpNQnNUYjcyNFB0RU1RTkFLaG02WTl6bXdkZ3BZY2g0ZnFRRXZZTjlx?=
 =?utf-8?B?em1wNnFzMVVoc2JKSE1RS0dFZURGSitHQXZaTXpIVEZYL0NHcXJsTUNpUEE1?=
 =?utf-8?B?NmE1NGtaODFLdkVPSkhGTFNORnF6NTVHYW5JRXV3OVJTZGsveTNwNDA5eXhu?=
 =?utf-8?B?NDRnbWp1N0VpMGc1WjVQZ0VENENLWFVYR3VyOWNRUGNNSENvdGtaeWhjU1d5?=
 =?utf-8?B?V1VIYVpDcndRbWdrUjRCc0kwcUJEc2lhWEdMZ2dIemFWZUFKTWtwUjNUbmcv?=
 =?utf-8?B?TllIK2k2alJhWjJRUjUrZ0Y4bmJsbUFRanVSKzdtMEQ2Y2dSWHhrVkFhRW45?=
 =?utf-8?B?RENhcUlRZUdwNnJXWTRUck1JYVRnRE8zbDRuVVAxWVdVcVV2dUZtcXBlY0lv?=
 =?utf-8?B?UW54TVE5VDRFdFF5N3NBRmhMTGpsd3ZpUWNOYWIyMTRmRGREV1hLVHJMdFlR?=
 =?utf-8?B?WU5aTjhPZTVlMmpsbW5mRE5maDAvU1dKZUhhRjluNWRSclptS3ZGZjZoSmdT?=
 =?utf-8?B?ajFubkhUWkFYbEtrNjlKMm9WamZLS0dFdEszREZOMDdyc2lvNmJRN1NVRktj?=
 =?utf-8?B?WU5sSWJ2UlVCcEo2WHlLd1FhZ3lKNEcyY0ZiL2RZOE52OEtFVlpyR3FaSXd5?=
 =?utf-8?B?U05zZDUxdHlJMUJBcnhaQmQyWnA4S0RobDRkTzN2UzVSZHIvZDNhTVgrelJW?=
 =?utf-8?B?ZkN6dWNTcjk1TzhGc3JmMzJOcjgybnJWTkVKQXI0WjVOd1FrTmxGVWpQbVcz?=
 =?utf-8?B?NFZ4Z0NvUlBYY3d3Z3oxTkk2OW01WU9IZ0IrOGhjem45VzNNTDE4aFFKTFFq?=
 =?utf-8?B?TWcvblpaek5iUERFNWFhd1R3TEtiY2I5V3QveU5IaHFmQVF3ZGMwdWlaNDNn?=
 =?utf-8?B?c012cTAxRUpLOWdNTDFoNE1Db3YxQ0FkYzMyVUlpVGI2VFFNVjgreVprMXRl?=
 =?utf-8?B?bXpJMkR2aENGb3c3Qmx0eWNJMVkxcWlTckpzamxXU0plOGE3UDFMU3RBRWFw?=
 =?utf-8?B?dHZ4UUJCYVI0ODZMMXF6ci8vU0RmVE9JSnNNTndzak0wenlGTFJFa3dLOXR3?=
 =?utf-8?B?SWdkZnFFNGNVeXdOTnVjV0piUlJub3piS0pUeUd4YmtOeUk1Slc4Mk1XZk9s?=
 =?utf-8?B?eGcxVXo3clp4bGJySEJxdytkd2pML3BxeDlndG1qb1dXemMybWFvb2NNTEtq?=
 =?utf-8?B?eUcyZGtCU0xhTEs1d25sSmNCSUZJWXNEOWFNdEJDZmZkeWtrVlhLbHJhYmN5?=
 =?utf-8?B?N1Z5WitwYTBobEplMUNGU0VjUEtsRUo0Qk9CUy9vRno2VGVIUmt6Q3VVaEtr?=
 =?utf-8?B?blhMODhDUURBM1lMRnA0VUNtc0VqMm1rUVNGQkdPQkp0bnhLMloycnBmZW1P?=
 =?utf-8?B?dlk5WFpyUUZHU2xhOUxPbHUxd1RYS1JBVmpwcFIzNTE4VEt3azV3cXpCT2Vt?=
 =?utf-8?B?dVNPQTNzOHpGYWhRRlovZ1N1ZGcvTEFTQ25aVGJsRktTN2d0aWtPYVFuVmh2?=
 =?utf-8?B?ejFBVXNpS1JTbnM1Mm5Yd1V0MDVRZnRDRkJBQlYyazAxNzIwN3c3OXVKckg0?=
 =?utf-8?B?V2JCSUxtYlNIOWF0dzZyMEI5STZIZ2Y4ZG5CNnRqemQxRjZBVE1NdnVnelIz?=
 =?utf-8?B?amMweHNPNFcxcHhoc3REV3kyUTZzT1h1RWJzMisvWXorbkQvR3NEZTJOSXI5?=
 =?utf-8?B?VU9SbTlMQnpNTzMrckMzQkVDVUZkUm5oZmdPNUpDaHI4SHhMUGYzcGxXUTZY?=
 =?utf-8?Q?m8EG2FtT3Xf6i0LLGf+OVBmhc9W9jY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 20:39:06.7775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c9579d-e54e-41a5-1eed-08dd5a93718d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

On 2/20/25 2:00 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/mbox.c   |   3 +-
>  drivers/cxl/core/memdev.c |  25 +++++
>  drivers/cxl/core/pci.c    |   1 +
>  drivers/cxl/core/regs.c   |   1 +
>  drivers/cxl/cxl.h         |  98 +----------------
>  drivers/cxl/cxlmem.h      | 108 +-----------------
>  drivers/cxl/cxlpci.h      |  21 ----
>  drivers/cxl/pci.c         |  17 +--
>  include/cxl/cxl.h         | 225 ++++++++++++++++++++++++++++++++++++++
>  include/cxl/pci.h         |  23 ++++
>  10 files changed, 293 insertions(+), 229 deletions(-)

[snip]

> +/**
> + * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
> + * @dev: driver core device object
> + * @cdev: char dev core object for ioctl operations
> + * @cxlds: The device state backing this device
> + * @detach_work: active memdev lost a port in its ancestry
> + * @cxl_nvb: coordinate removal of @cxl_nvd if present
> + * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
> + * @endpoint: connection to the CXL port topology for this memory device
> + * @id: id number of this memdev instance.
> + * @depth: endpoint port depth
> + */
> +struct cxl_memdev {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct cxl_dev_state *cxlds;
> +	struct work_struct detach_work;
> +	struct cxl_nvdimm_bridge *cxl_nvb;
> +	struct cxl_nvdimm *cxl_nvd;
> +	struct cxl_port *endpoint;
> +	int id;
> +	int depth;
> +};

This can stay in cxlmem.h, only a pointer is being used in cxl_dev_state.

> +
> +#define CXL_NR_PARTITIONS_MAX 2
> +
> +/**
> + * struct cxl_dev_state - The driver device state
> + *
> + * cxl_dev_state represents the CXL driver/device state.  It provides an
> + * interface to mailbox commands as well as some cached data about the device.
> + * Currently only memory devices are represented.
> + *
> + * @dev: The device associated with this CXL state
> + * @cxlmd: The device representing the CXL.mem capabilities of @dev
> + * @reg_map: component and ras register mapping parameters
> + * @regs: Parsed register blocks
> + * @cxl_dvsec: Offset to the PCIe device DVSEC
> + * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
> + * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @part: DPA partition array
> + * @nr_partitions: Number of DPA partitions
> + * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
> + * @cxl_mbox: CXL mailbox context
> + */
> +struct cxl_dev_state {
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_register_map reg_map;
> +	struct cxl_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct cxl_dpa_partition part[CXL_NR_PARTITIONS_MAX];
> +	unsigned int nr_partitions;
> +	u64 serial;
> +	enum cxl_devtype type;
> +	struct cxl_mailbox cxl_mbox;
> +};
> +
> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
> +					   u64 serial, u16 dvsec,
> +					   size_t size);
> +
> +#define cxl_dev_state_create(parent, serial, dvsec, drv_struct, member) \
> +	({								      \
> +	 	static_assert(__same_type(struct cxl_dev_state, 	      \
> +					((drv_struct *)NULL)->member));	      \
> +		static_assert(offsetof(drv_struct, member) == 0);	      \
> +		(drv_struct *)_cxl_dev_state_create(parent, serial, dvsec,    \
> +						    sizeof(drv_struct));\
> +	})

This should take a CXL device type parameter as well, then you can also use it in
cxl_memdev_state_create() like this:

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 2c49e33851b2..14d7f93e4584 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1484,24 +1484,31 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, "CXL");

+static void cxl_memdev_state_destroy(void *cxlmds)
+{
+       kfree(cxlmds);
+}
+
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev, u64 serial,
                                                 u16 dvsec)
 {
        struct cxl_memdev_state *mds;
        int rc;

-       mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
+       mds = cxl_dev_state_create(dev, serial, dvsec,
+                                  CXL_DEVTYPE_CLASSMEM,
+                                  struct cxl_memdev_state,
+                                  cxlds);
        if (!mds) {
                dev_err(dev, "No memory available\n");
                return ERR_PTR(-ENOMEM);
        }

+       rc = devm_add_action_or_reset(dev, cxl_memdev_state_destroy, mds);
+       if (rc)
+               return ERR_PTR(rc);
+
        mutex_init(&mds->event.log_lock);
-       mds->cxlds.dev = dev;
-       mds->cxlds.reg_map.host = dev;
-       mds->cxlds.cxl_mbox.host = dev;
-       mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
-       mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;


Looking at the above, it occurs to me that it may be good to either:

a) Have a devm version of cxl_dev_state_create() or,
b) Have an init macro (in addition) that takes a pointer so that you can use an
allocator of your choice

Neither are necessary, but would be more ergonomic IMO.

Thanks,
Ben

