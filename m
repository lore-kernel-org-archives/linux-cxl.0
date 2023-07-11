Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53176EB64DC
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 18:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjGKSTE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 14:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjGKSS7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 14:18:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B989C
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 11:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKBAfjyu9L148TSJQvGaEwXbdabNTnGTT94ylSmoBGUwiaAFVBsJALVrM0sgOHl4K3qKCq5sjcj6DfaoHspySmUmddiQGoSKAI5SdWJsPMnOqsxCOYhH8Y6uBHDTGgrcMtUu2A0LI+bnPbefLPR5cANjfpoHvxcDF+Rn4X6qmaxbjhIvVflTMHYeZKw/+7v99m+XepmuGI1Ot99PB6zNyLxkWcGTgGpEBF5HR7+hI+DVqdiFd4n05BRThvbKzvWRSGJDgMUpHyh03ppqYwSMpUWDa6EYWJwjsibPjNBpyZFko1F0d6Hc4vLuv14J4ZxSXC33Dw/y59ypS2a9/7MkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44FVln5UnITqwaIiaHANcx0dJMieKo0BTfw8ESvdQrs=;
 b=L4T7WBD8NkjWXgUBVm5lzPMwN5mFjsBMTRzkHO561KtdnN964KLDdKzZtfHC1mHvJVFz9rG2W3zgV35XY66kTmhP3SjoAwHTgd8ridRvgXCeXwVZd7OAvESB/HTi76mgTQnpNzdQKlFZZFncnogtTHLTD0PAz5wtKcteb9JwpQVKffTb4NhBoAS86L55WYYHoBVtZDeZafHUOTvRePHONAWgRojdBVTs9UsYfC/t1nk4uuDPhz/zMAOrMluMBIcYTcKNIY0IjfTVGCya6Kg+frYqJLpjGcg7JKV6PGP90DxhhMde/cen1qNs0xXlJU2/mONujk4cdT06Kp3wesuLpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44FVln5UnITqwaIiaHANcx0dJMieKo0BTfw8ESvdQrs=;
 b=Ddq1/eCYlkn2fUtDOBXP6sJibZ4D+5KvLRixdx2O7dIiO3rGZWIJEOG97ArP164GmRF5xJGSq1usa1MMbwIFghEK+DHVvewfQa2VTf14tYAcnWMDOT/wZFpDwM7tSCrtgcCZlQB9s1+OG2lYX4RATKf+BQVGfTDV/Q5JINo+Vrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH0PR12MB5433.namprd12.prod.outlook.com (2603:10b6:510:e1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 18:18:56 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::797:c2cf:9dae:5f50]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::797:c2cf:9dae:5f50%4]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 18:18:55 +0000
Message-ID: <0975a0d9-7b9b-e959-5621-928ac90fcb66@amd.com>
Date:   Tue, 11 Jul 2023 11:18:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9] cxl: add RAS status unmasking for CXL
Content-Language: en-US
To:     Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com, lukas@wunner.de,
        Terry Bowman <terry.bowman@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Richter, Robert" <robert.richter@amd.com>,
        Fontenot Nathan <nathan.fontenot@amd.com>,
        "Kodamati, PradeepVineshReddy (Pradeep Vinesh Reddy)" 
        <PradeepVineshReddy.Kodamati@amd.com>
References: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0049.namprd13.prod.outlook.com
 (2603:10b6:5:134::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH0PR12MB5433:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fe5d323-2000-477a-757b-08db823b49b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DQXEsE/iYGwITuNctSXE+HRhAppTpdm6GI4UbZUq+0E4iITuC5u4vG2kcbKTThXq9iz9aw6GhIqvuHLIzkxzDuC0TdhBzVaV9rWDdP6ebAJ65qiiYbQOMJmz7Ndp5PQG29CJb42fZc2pb6bnH3wmUmcVtWOk0aHzb8D3u5HQuj+2w9VsPoQ7+zvQOPRd5Aghjw+dqsdxhbGdxxXlenbj9UgJDsCTpwLZP/XLklcweZ6AvBatgznkHYMqKxpO5N/w8autmAH91cJ/l+gRuTn4aTY1shudIyPE/mqly44ZDokAjhnHGtPlLu9BsW+4ThchNY2fyAH87nfH3pY9iRoGblv08xgCGLdF6QY/4Ko9vyuuyUzHiuBRqgvP4SupfxtUUYfg/2RsRznx5WUMB0A5wBwefkGywQ+0p5KV+T5b31y8bCqr9KtKMw0DGfnIykNkKRsey3qFfqu8CeUygd99JyShD5EknlTZRULB16lee7MgNSO7Cp5SiYPvyKioFEA2bcT4GATTd99ikkDa89QMOi6LtXmJeaUkmVAJWYXDFjVNXAGQqxpxN3KJyTkDKohwn8Tb+ak8JdnoRD94mL5ShC591xudHdeD7ORe4WN2d6CJg1d2dC534yPVH8zPABkEee8G294XSqAoJ+Z62yqunQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(346002)(39860400002)(376002)(451199021)(6666004)(6486002)(478600001)(2616005)(6506007)(186003)(26005)(53546011)(36756003)(6512007)(316002)(2906002)(41300700001)(38100700002)(66946007)(66556008)(66476007)(4326008)(86362001)(31696002)(8676002)(8936002)(31686004)(5660300002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlZrOG96M3FCanpqL3ovSGlNRFhZSU5jbTNhQXhzRmkySURYT3BrTFVRTGt1?=
 =?utf-8?B?QmlFL0NxY0d3WEZMQU83aU5IaEFiZVc0N0RNK2lEeGdwNUxUd0E5YWg5bjA3?=
 =?utf-8?B?QjBNYy9RcVlxU3MwejBVS3dWblM4TW5objFEYisxNW5wakVlVEN4VjlnbGpR?=
 =?utf-8?B?TTFYZ01iYXNQWnVxUkVtZjh6RGVaTVgvUHVjVU9UOWRyS2tUK1l3Qjh1YjlD?=
 =?utf-8?B?L1JaVzZiN0p3ODlDSFpYRUJLU24yd1UveWtSWUZ0R2cxVmdYcFZEZE9hV2ZI?=
 =?utf-8?B?L2QzZFpNWFh5bjhnQmVqRUR5SHJRVVE1YXljR2JWeGZCT0tCM0JBQkZSM1dE?=
 =?utf-8?B?YW9lK3FxY3lrcDNhaDZkTjEzZWExaWpaRnFnTk5yYnduOGRLRzJHSVVCWFRv?=
 =?utf-8?B?M3IwT1NMM2E3aTZtcFFtdzk5YW5SR0FHVmJXSDU4N0pGaXpicnhpNUhaWXdy?=
 =?utf-8?B?OWo2dnc1QVBWNnZkdE4xdFY3TVF5aGN2ZlZIeTVXL2tNcHphc3pra3o2WGh0?=
 =?utf-8?B?NVhxbTRSbzJBMlZlZ3VScjN2UG5MMENsRFdLa1FmSitTcnF2cnREeFM1c1Fp?=
 =?utf-8?B?YXZjeFNOUFc0dVVld2FybEZ5SmJNcTB0Q0Z4cHVvUm9hRW9VM1F6a1ZZU280?=
 =?utf-8?B?T2RDbTRKbzZJbkdZNUlPc2VYaVl4bCtlcFJqcWxNcnBzTmQxZEh4dlNiNW9a?=
 =?utf-8?B?VmpTZCtienhiUVZTL1ArQU1yVXc1QjA1TDd3VkIxRTdISndQUHQrYmVlSGpy?=
 =?utf-8?B?d09hVnJlaDZDck91SmtpZXlLR3g5azFMZDZrMFRIZmhpeXlVK2tHaGQwZk51?=
 =?utf-8?B?eGFldm04SjZNUjlsbWdGZjFtVlFoSUtaNll3clJLenZ6N1F3cnNMczJUYjVW?=
 =?utf-8?B?TWh3WHg3bjN4MjhPaWxIS082TTBWZkgrVG1Menp0T3VNT0lPczQ3U3NsZHFw?=
 =?utf-8?B?T1dHRHZ4YXA5ajl0V2VkS3JWMVFROHEvR0pLZVZ6c3lNNVF4QUFtSjRqb2x5?=
 =?utf-8?B?dVBmOUdtQzFaWUxuYzJ4b0d1VjFNdktUYSsxRTI2eld5ekNSZHBnb1NWaE15?=
 =?utf-8?B?TXZsTG9kc2w0VnNaaUg1VWtRWjlXSlV5UGh1L3hZenpSQjVKQy8rVFZSbW1q?=
 =?utf-8?B?Y05nYkhoMDFERXV6WFhKZTFVYXdzcWQ1eTJvcjFVaW5BWVlPcGM0SUw0Y3Uv?=
 =?utf-8?B?OTBMY3MrUnY4N3dnWE9QbGVEUUQ0TVJMZVZjc3RMVHJ3SjM5MU1FNGJ3QXhO?=
 =?utf-8?B?b2FqUnJyNDF4cUhNZ2JNcnkwODVQcnZibTRGak5uck9pcWJWbFpnMzZ2ZzB6?=
 =?utf-8?B?Y2gxWXRYQUpQQnJsU3Nkd3VyeVcraXZyOXVBZHR4YlYxRWVjeDJvYlFGclE1?=
 =?utf-8?B?cFBOZmRUb0lFZDhsWVNGaGZSL2E4dksrVVZQMHJvVENOOFBuQmlPY0N0Q3RN?=
 =?utf-8?B?Nlc4UkpWTDBSbmVYS1FTbUJadWlwS3YreEtSWVpLTzMwODVsVDY1cURVTU9S?=
 =?utf-8?B?aFRXUVpBWmNQQU5EMHJ6TTc3eXl6bGZ2UURpK3Rnc1VjUVBTY0kvZTdCY2Rp?=
 =?utf-8?B?b2Q2VVhRWEtBNnRsaURsOFdzd0F2WkxNSStLdGovcDF6T21ZWlRHQTdHT3Ay?=
 =?utf-8?B?QkxQNVVGbTBvVVkybGJKcWNRRGlSekNDSnFyYU1qOFU4eU4xRXhDTEt2K3Zz?=
 =?utf-8?B?R0xLUEdrWVBCTzM3VDJSaldOQ255UDg2SXZFTHdUT2I0Q0h0WEdRZVk1bGxX?=
 =?utf-8?B?UUl5M1VHNWQrdHdFbmNnSjlpLzd5N0tOTEFKaTRmMUVNbVFlVDNGaVU1OUZU?=
 =?utf-8?B?bFIzR1pEVnZMdVl4dXBwdjg1Y3JkelBLekNkY1BhcEdQNDVyVGNndzFDT1Fy?=
 =?utf-8?B?dWtMUDVHYXRqdFdTZjkwUUswVmpxQlk3U2tjUDdqbmUwUnFtQUIyNmFRUFBm?=
 =?utf-8?B?T3NSd2NQUHBmdTRWRFN6emdseWhKaytVT0haTG0xYmR5bEFhYlB3K0prRlJs?=
 =?utf-8?B?aDFPRmV3VVJPOVBqVnZoMU1yY3NRNHpScjU1RTRrRTJkZkZ5bUc2QTVIOXdO?=
 =?utf-8?B?WC9ldTFHd1EwWk51OUl5TjY3NmRNdFR3WFdabGV6WTdrUmJ1cU9TMjR0ZEJz?=
 =?utf-8?Q?0zhn//T0wH02AVajqomzWpsl6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fe5d323-2000-477a-757b-08db823b49b6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 18:18:55.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xlFo4YZkJA+KrtfJbHm2RBYqNoMsTCOHvt6uys4zlX98QtbftoLYbvFOBoLDt3eEnoWTjwxSZKbKo6aAETBjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5433
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi all,

I understand this has been in upstream already. But I have a slight 
confusion on one of the checks been done here.

On 2/21/2023 9:55 AM, Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
> errors bits are set before unmasking the respective errors.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---

> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	u32 orig_val, val, mask;
> +	u16 cap;
> +	int rc;
> +
> +	if (!cxlds->regs.ras) {
> +		dev_dbg(&pdev->dev, "No RAS registers.\n");
> +		return 0;
> +	}
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;

Why are we checking for native_cxl_error (native_cxl_error is CXL Memory 
Error Reporting Control _OSC bit..) while unmasking RAS status?

RAS registers will be reported on a protocol error and the protocol 
error follows the PCIe AER. Should we check for AER _OSC instead of CXL 
Memory Error _OSC?

Because atleast on AMD systems we log RAS registers only on Protocol 
errors and we use this CXL Memory _OSC knob to report component errors. 
Is it same across everywhere? And there might be cases where protocol 
error reporting might be native (PCIe AER) and component/memory can be 
FW-First which fails this check..

Thanks,
Smita
> +
> +	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
> +	if (rc)
> +		return rc;
> +
> +	if (cap & PCI_EXP_DEVCTL_URRE) {
> +		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +
> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;
> +		if (!cxl_pci_flit_256(pdev))
> +			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +		val = orig_val & ~mask;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev,
> +			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	if (cap & PCI_EXP_DEVCTL_CERE) {
> +		addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +		val = orig_val & ~CXL_RAS_CORRECTABLE_MASK_MASK;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev, "Correctable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}
> +
> +	return 0;
> +}
> +
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> @@ -728,6 +789,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> +	rc = cxl_pci_ras_unmask(pdev);
> +	if (rc)
> +		dev_dbg(&pdev->dev, "No RAS reporting unmasked\n");
> +
>   	pci_save_state(pdev);
>   
>   	return rc;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 85ab1278811e..dc2000e0fe3a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>   #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>   #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>   #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		0x0400 /* Flit Mode Status */
>   #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2	0x32	/* end of v2 EPs w/ link */
>   #define PCI_EXP_SLTCAP2		0x34	/* Slot Capabilities 2 */
>   #define  PCI_EXP_SLTCAP2_IBPD	0x00000001 /* In-band PD Disable Supported */
> 
> 

