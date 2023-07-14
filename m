Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86248EB64DA
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 13:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjGNNvV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 09:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235136AbjGNNvQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 09:51:16 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F60271C
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 06:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IonEM5FLD9Lz6RS0Th7Ab0vCGj4QmgqKcZAgT/ZQMUAIh6B9hKlv9zRXo94hRjhr6jOwNdHLKGBdQl9V8+F63bD4rgpjCuVOx6b0kKG9WjFCcX54U2d9C20L/9NM1EyuEe4fZP1sWK4+SStIjEPR2GtRLGvOjLlVnpe1PSWtf86fhEXJ0N/AQX3OPvhcyFD8fxPwLghFeQKuacXWBrlA+NkE31P+veurblPsHnbh/8nlZ3vNzPQd0+1MlTlPLj+SmiGOcGkPTIpV05x5A9B+SFDP/uS7v4P0EzDOwWK3I5xdTINmFqQRFsdX2g1uljk4+i4F633FxdkVX/o93v3KQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ogKTmxfZRlTR0cQCnUGmibEWlf/z1kj/9NI8K9WzvhE=;
 b=DhLOU8ukSm99Ape7ebvTmLVB451slRHhqqb9yqO4+TaMvveMSQPQIxOd+y02hsTFn2yy9XlQSr/NE7kFUV7ihep7YROZ0zgU6GVUbEBenPm4DqQD0X+jxKsGXUIkJKaRHX6BUKPD2OOXwsX3dAimkxtpuL5Anw1Xo7+hRqz7abc9wJBI5/UwyxSeeR3Hxn+NMX/mxz3PeEFZKbntYk31pIx5nCYrX4djKBY4Zy8vMS6cINemdxoPG4bLWuwPcuOEqSEZ+xN8lcOLo4r7POKnnOAh8cy5ePevxJAVA/HGS1TrMYPsUuyXw9OHOB59aVmgdCmYGkVm7pyoYzXWAYQ1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ogKTmxfZRlTR0cQCnUGmibEWlf/z1kj/9NI8K9WzvhE=;
 b=KFQvjGDityBIzY6wp2Vna4Ar05l+0Tmryy8X7d6WMv8EQMT3LBEGHx1exukNlogmtx6I2vPf9YekCcqVt3VasOveJrb4nh1uBdyi6MCG+cespb1XZ7CoEZ0+2cbEH45tRanBVQ8FAJgXBcMz9p6AD+fAeSVxucGV9eg1UpckNwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Fri, 14 Jul
 2023 13:51:12 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9a77:e0f8:85fc:b871]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::9a77:e0f8:85fc:b871%2]) with mapi id 15.20.6565.028; Fri, 14 Jul 2023
 13:51:11 +0000
Message-ID: <d9deffe8-04bd-8df8-dab9-dc85122ed648@amd.com>
Date:   Fri, 14 Jul 2023 09:51:09 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, lukas@wunner.de,
        Terry Bowman <terry.bowman@amd.com>,
        "Richter, Robert" <robert.richter@amd.com>,
        Fontenot Nathan <nathan.fontenot@amd.com>,
        "Kodamati, PradeepVineshReddy (Pradeep Vinesh Reddy)" 
        <PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v9] cxl: add RAS status unmasking for CXL
To:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
References: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
 <0975a0d9-7b9b-e959-5621-928ac90fcb66@amd.com>
 <64b06ad8e5505_45a6294ca@dwillia2-xfh.jf.intel.com.notmuch>
 <82e7070f-65dc-568b-3b89-a879517a3b94@amd.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <82e7070f-65dc-568b-3b89-a879517a3b94@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:408:141::22) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 452a386b-1195-46d0-f869-08db847161e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2sb4u0EhOHeIJkyNa9WcBJWGrEdmPK7v8le2dc1Ke/GEFYRa5x6q5lDu1D2AYRvXhKwlBlXrpy7pb/ZKaMWZYcL+nJXfFISx/12cJ2vTKTsVlQWDpr1ez1eP/7FWuW++3H3LX6lPCUamyVarN8jhjzLoJOXU9AEGPMRFBbWWCqlm+nzpg/7Oc4yWBKA9N39HVAZa/2OVFBoZLg3zhX8sNJBZNgOL+JDmX4VQzm4sb6ufj6YKUFopRbvBcfblS9OhJW9H8KohN/jIZdRTbVwJWch+OXVPv2GJTAwVgFloPu1MngNK14Wjw7WYrDINtC2nMYUhNkvUPUVXHDpz02veoHeExKpo65LfbDhQNr7tNeXc/2d90CiwRNe36OTfGIwJM55oDjv7A04kbub6Gb7jsRpjY2kO4GqgoSzYnVsQOlr6/wFlbnuyI/d1sI7PAj7tpReMsQbkpmzsZOMOddhqGDr6+uWDgj1is9V6UH+BLEsbQKyC00OVazYyUc/VU/946WLb0hxlYAgcdp/FkexM47xb8lu+0oxBdrS/HTM3rPRHxl5xzRpLQn+zNLCgLOtxQlGqqWgdESUeYumeYbHkngoFAAU2ZmHaYk0Z88WSHl4yFgIhRFfhk5z3vXw7gQGSvamfLi+xQOMIuv9dcaSyQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(31686004)(2906002)(478600001)(110136005)(6486002)(8936002)(36756003)(44832011)(41300700001)(54906003)(316002)(66946007)(4326008)(66556008)(66476007)(8676002)(83380400001)(6512007)(38100700002)(86362001)(5660300002)(6506007)(31696002)(26005)(186003)(2616005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TExCSFRPVnFTRUFmbFg3ZDB6eVlBL1dVTGU5Nm11L1VEVFpDd3pCemhBb0FH?=
 =?utf-8?B?T1pCV0w2NUwvVmtRTFNvVFBidWJ2eDJCZDdTNER4eFk1SFRGY3E4MTk1L0Z2?=
 =?utf-8?B?SElMSHE5bWo4ZFl2OWswemlwa0FyUTVrSTlCZ0tVUDVzYW5wWHNjN1JrdjV4?=
 =?utf-8?B?S0dCZjQ2dGo3aDdnWXlXSW10VzFLaTVNWWRTQVJ3NEp6WUhXdExRYVNsNVhK?=
 =?utf-8?B?S3lPd2k3cEcxOW9meUtCQlMxRy9iTW9zU3FwZG9vTUx6NXZhQnM4ZUxYYnY4?=
 =?utf-8?B?TTlyZ0Z3SEZSMnZ3MnppdHFGNFZwQWYvOU1qb25SeFJkUTdKRnRlcDZXdjJ3?=
 =?utf-8?B?Zk1yc2FibnYxZjYxak10QWk0UDNmU2JrVGsvM1RnckQ2VHRxVWp2d0tEOVp0?=
 =?utf-8?B?VW80eXBCbTZwWThLa0dLanUySGkzd2NzY1AwYUQvTG5KQXo5ZCtNbGRoWUVN?=
 =?utf-8?B?NVVBd01hL3g2UVFCcnlEdmZYN3pGSXd4NmpIVTd1ZE5YNmI4eDdrUVVEK291?=
 =?utf-8?B?N2E5SUQ4WkJhYU5zcEdwb2xZdExhT01aaHJ6TW1qWjBZSjdkUlI4TDIrTVhj?=
 =?utf-8?B?NlNSVGJiTTNFc2xKbVVKdXpQQ0NXOFJMUDE5V3ZnVm84ZWJGWHB3R2hRSFZK?=
 =?utf-8?B?SFRaL0JkcGhjbkx4NmQvWDNZMXNITHZyNXRZK20rTGxBRjJQRzBqSUhydVh0?=
 =?utf-8?B?ZC9ha0NCTXdSMlJpdTdWYkQySDdKYkJFQlB2clBvMk1mcVlWVXhXS0JuRlVp?=
 =?utf-8?B?azFWTlBzS085dmx2MThJVnowblJualA5cGd6U091V2xPaCtoT29oc0ZxVGtQ?=
 =?utf-8?B?aERhQUVrbnZodDI2cjQwRzZIdXNOSDEwQkdSU09tNGVmWFI5VjlFK2ZySHpQ?=
 =?utf-8?B?ZDVHR2NzVm5hNjZQbXUrVjcyU2JRRXBoVlVQTTlhTE1MUXR4Q3haUE4wRGxH?=
 =?utf-8?B?dmpXbm1tSXVHbTd2SXBxL0xZUHVzbVpXZ1lUaWhkWXcxYTN5bW5pTVp5Ykcz?=
 =?utf-8?B?czNocGVoRnNqbExkNWVhYUNoR3BpUGprS0d2d0dTY25HK0ZxNUliOVNCVTZz?=
 =?utf-8?B?L0ErOXpUeXh6YkRReG1oeUh5L0dFVXBwV1lVZDA5QVFxeG1xaWZpRzNtS01u?=
 =?utf-8?B?cjVOOCs4RFl0em43NjMzMVF4dFNMeS9mUFkxV0JVdEU0ekpMdkMyK2grbW9C?=
 =?utf-8?B?bmVNVU50dHd0cFBnOUdXbUphb056dExZdUVqNTRqYU1sMVkvMEZ2US9WZWJP?=
 =?utf-8?B?OXJlMVJjQS9Wa2Fmd3d4L3VNQzV2Uld5VzhZRlFXR3lEaFlaSzdiZlQzMnZt?=
 =?utf-8?B?ZU84VkNKWU10b2hwbFJmc1NCU3VZK2s0dHdyS3lqYXVPbXQyNkZHdmNKalZR?=
 =?utf-8?B?clNuY0I1Q0V3ZjZKL1BjL1VFektQcmtDOGhrVFIzMitKSmpxWHBpdmZSRWtX?=
 =?utf-8?B?cHIzRkdCR2hzNWJIYnk3cGE3MVkxc0JJbkhYeEZJVlZhTnh0V29wL1pTQ1VP?=
 =?utf-8?B?OXAwTFQvQWJ5VWlLckNYTlZSM25RN3ArL3FLeEV5Q2VRS3hUbWVydlVQMHdE?=
 =?utf-8?B?VFlnSGRCaHBJc3NMOU5hSTFkRGJlMnhnV1VUTmZ2YkJBZHZvUStobVhIbjht?=
 =?utf-8?B?ODBDTUFVL0pyRTM5ZU1oODlUKzI0bkp5ckE2OVl0cEZXYzc1TldrYnNXRUJW?=
 =?utf-8?B?U28vRXdvK05JckJrKzZIczhnZFdrcXp0eVJxL0dMVkRkTFEwVXhNbXlBMmhn?=
 =?utf-8?B?MUJzOWI1VCtnQmkycjY3L1Z6YmY0OCtOZTdYSlQ4VStBeW9OMjd5UHEvVGw0?=
 =?utf-8?B?ZHd2S1lJcC9NeWlnUW5QNHpyNlc1bWF6eFIyNlNxeHN6V2w4UHlkZHhlV3A5?=
 =?utf-8?B?SG5XenliMHRydjk0TGh6cDJkSHFWZ2p3UU4zZjE4SEFJTDRmMnpMNjk4elY0?=
 =?utf-8?B?WXQ4eG14TFpxQ0J1SUp1eGVNME01aEJhTmcwNUJBb1BZR2JlZnZCREFPMzJh?=
 =?utf-8?B?eEZlbTF1UnR4aTJ6RzZSUzR0QVVjbWkyWnVISUdFK3gzQzZSNmxlQUpHSGRQ?=
 =?utf-8?B?VzNqcWVrV0hNcDI3ZjJ3eThKaHJJSUxGOGNkYk94M292bHN3ZE5QTjhmenBQ?=
 =?utf-8?Q?adtGQ0czVIXsPcHa1u9D9z8uG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452a386b-1195-46d0-f869-08db847161e0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 13:51:11.3159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geRGZFGWNQmiAo/wSRgRmxWqQmaxrFSH5il16RCloWf4EM/U80I0c149XgdFfp55aame0Y8hS1pesd2sJzu5+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/13/2023 5:50 PM, Smita Koralahalli wrote:
> On 7/13/2023 2:21 PM, Dan Williams wrote:
>> Smita Koralahalli wrote:
>>> Hi all,
>>>
>>> I understand this has been in upstream already. But I have a slight
>>> confusion on one of the checks been done here.
>>>
>>> On 2/21/2023 9:55 AM, Dave Jiang wrote:
>>>> By default the CXL RAS mask registers bits are defaulted to 1's and
>>>> suppress all error reporting. If the kernel has negotiated ownership
>>>> of error handling for CXL then unmask the mask registers by writing 0s.
>>>>
>>>> PCI_EXP_DEVCTL capability is checked to see uncorrectable or 
>>>> correctable
>>>> errors bits are set before unmasking the respective errors.
>>>>
>>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>>
>>>> ---
>>>
>>>> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>>> +{
>>>> +    struct pci_host_bridge *host_bridge = 
>>>> pci_find_host_bridge(pdev->bus);
>>>> +    struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>>> +    void __iomem *addr;
>>>> +    u32 orig_val, val, mask;
>>>> +    u16 cap;
>>>> +    int rc;
>>>> +
>>>> +    if (!cxlds->regs.ras) {
>>>> +        dev_dbg(&pdev->dev, "No RAS registers.\n");
>>>> +        return 0;
>>>> +    }
>>>> +
>>>> +    /* BIOS has CXL error control */
>>>> +    if (!host_bridge->native_cxl_error)
>>>> +        return -EOPNOTSUPP;
>>>
>>> Why are we checking for native_cxl_error (native_cxl_error is CXL Memory
>>> Error Reporting Control _OSC bit..) while unmasking RAS status?
>>>
>>> RAS registers will be reported on a protocol error and the protocol
>>> error follows the PCIe AER. Should we check for AER _OSC instead of CXL
>>> Memory Error _OSC?
>>>
>>> Because atleast on AMD systems we log RAS registers only on Protocol
>>> errors and we use this CXL Memory _OSC knob to report component errors.
>>> Is it same across everywhere? And there might be cases where protocol
>>> error reporting might be native (PCIe AER) and component/memory can be
>>> FW-First which fails this check..
>>
>> I think that's reasonable, it just was not clear from the specification
>> that CXL protocol errors are included in PCIe AER as far as _OSC is
>> concerned because they are conveyed as "internal" errors.
>>

I think the CXL spec is relatively clear here.

Protocol error _OSC description:

	CXL Protocol Error Reporting Supported

	The OS sets this bit to 1 if it supports handling of CXL Protocol 
Errors. Otherwise, the OS clears this bit to 0.

	If the OS sets this bit, it must also set either bit 0 or bit 1 above.
	Note: Firmware may retain control of AER if the OS does not support CXL 
Protocol Error reporting because the owner of AER owns CXL Protocol 
error management.

The last note shows that AER and CXL Protocol error handling are tied 
together. This is similar to how we tie AER and DPC, I think.

The key difference is that the OS can't request control of CXL Protocol 
error explicitly. The OS tells the Platform that it can support CXL 
Protocol errors, and the OS can request control of AER. The Platform can 
then decide if it wants to give the OS control of both AER and CXL 
Protocol Error handling.

>> So I believe it was an "abundance of caution" more than a requirement
>> that Linux expects control of memory-errors before proceeding to touch
>> the CXL RAS registers.
> 

The "CXL Memory Error Reporting Control" _OSC description specifically 
highlights the "Memory Error Logging and Signaling Enhancements" 
section. And this is the set of errors reported through a device's mailbox.

So CXL Protocol errors (AER + CXL RAS cap) and CXL Events (Mailbox/Event 
Logs) can be managed independently.

Thanks,
Yazen

> Got it. Also, are there any issues returning zero here, rather than an 
> error code just like we are doing in cxl_event_config()?
> 
> The error code returned from this function wouldn't grant cxl control to 
> OS (i.e fails to create device node /dev/cxl/mem0) which would confuse 
> users when they are operating with native PCIe AER support.
> 
> Thanks
> Smita

