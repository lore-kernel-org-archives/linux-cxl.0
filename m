Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99364C001DF
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Jul 2023 21:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjGMVu6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Jul 2023 17:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjGMVu4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Jul 2023 17:50:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35BF2117
        for <linux-cxl@vger.kernel.org>; Thu, 13 Jul 2023 14:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J825wa0JV3oa+Us6QA01JhIVq1Bi0//sl2t2mGlEdhVD6IODMb2JFmmNrW6kTZGW5RNV6NmJQoNs48TfEX88EZCzZ+mSn3MtD/3bSS2Zigqkxl5u6AMZ6P6qR42T1LwCr3G7CrIsAyqAX3UoE0eU+2qvmeBJG/dWxixCdR+WiXSi3FXmtlbmG+t69Qt7T04o+apFi/Xizqv7APvKrcuRcYHpvwBU0l7XpFMPEjLavAlbVgxOA6sBvAhzJGHJLLf3qGfUG313s8P3zQVrf5ev3Et4VYAZq5sNw3ZHOec7z8u/WvyvlLylqBnOOH2djz+Q5mf+oR7d8KljOt2SyeRXaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mncRezvB47S9XlgbbWaYCF9C37uo3lEd4r8suVd+EZQ=;
 b=YxUO4+4Cn6b1mC8vExlPIgnl/I7lFJaXscXxxfKdZnhx0bz4GHhVC2bczHqtMo0GROLwQlq5CfgxcFt/rYPYrYzg9kKNtrbxgvmk5kEzrgOQRTJVsn/9CuWfQibGrMyThSFuudopIlmmH8pSBlEzcOjHgwpreUro4rJl+BD0lSRvjtaSxNEZJQPmP39YPaF2XavL7ujWBv8QKQnYX1Cqt6jivfr55RuYXqccRAT4qATbb0SRaErGJKhZM/0EXbg0DuY5hE02ULIdQICLA+d865Nvj6onNXM++ppiTtOloeXMQzpQ4x+BwyFxLJt9X0nk2ZGVAk9NIeQGo0jLKkQYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mncRezvB47S9XlgbbWaYCF9C37uo3lEd4r8suVd+EZQ=;
 b=Vq+Y5AvwFyuxrWuhI+UVsDkAwN4o0h15ICnuyyZUkS84orzALhiWbXY+cnyEMAyxCRWbPjVUPi+sEK9YJHZ7V9x9n9uR894ZacJQPT92hwZ5fXj4UHR/KaLfWxxnmfobgKi9Z72JQhpt1acY+xc9JhYaNaPJqp7csws69GoNSlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by IA0PR12MB7603.namprd12.prod.outlook.com (2603:10b6:208:439::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Thu, 13 Jul
 2023 21:50:52 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::797:c2cf:9dae:5f50]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::797:c2cf:9dae:5f50%4]) with mapi id 15.20.6588.022; Thu, 13 Jul 2023
 21:50:51 +0000
Message-ID: <82e7070f-65dc-568b-3b89-a879517a3b94@amd.com>
Date:   Thu, 13 Jul 2023 14:50:46 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9] cxl: add RAS status unmasking for CXL
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        ira.weiny@intel.com, lukas@wunner.de,
        Terry Bowman <terry.bowman@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "Richter, Robert" <robert.richter@amd.com>,
        Fontenot Nathan <nathan.fontenot@amd.com>,
        "Kodamati, PradeepVineshReddy (Pradeep Vinesh Reddy)" 
        <PradeepVineshReddy.Kodamati@amd.com>
References: <167700213490.106661.13890376014908981260.stgit@djiang5-mobl3.local>
 <0975a0d9-7b9b-e959-5621-928ac90fcb66@amd.com>
 <64b06ad8e5505_45a6294ca@dwillia2-xfh.jf.intel.com.notmuch>
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <64b06ad8e5505_45a6294ca@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::23) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|IA0PR12MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: d48bd6cf-a30f-48ba-2e06-08db83eb3995
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OeFHfurDYVWUgTzDYSBlOPG2uVMU9D7Ccm4d3RfCV11D+9ktUO03ZTEnhV6263FrD4AJZCs/N2FAaBTF5N8a6beInoOv6UkWcY1eEK8jzuovyVn9b3r/MLplNtf5lCxCdhh7dH1sXJ/0AyMJxTTCM/TJrNJpxiGMhh/CpLnHFdnJTqH3c/Q8CkXcHnwCPjAYyyagTf1tJi8JpxuFJibxFMTuJbj37uGHWY0A5BehPdnKqeLCcuDbfhxTXxi+0+nPdQjNgJhO+J/fMffpSjispA4V5HCGJ/1fF0xU3jR7WPt1lU5pTmjT7nPAXYSnakQY8v9/ukE7za7YGHkMOH2Yg3LyjCvg/+P3yWo5ZmVTDKThWlt3Dtl4AZigH2suwudKh3mUACoUMWqBgwI4RGmU8g8zQu9I+jkWcdSTcoVmnRbdm+e+TI6Re1S121wPZQpSVuehZQqame8XLLH6aN3mQyWPwiIqqrvev2M/uXJxL7tdv8GT+aKorKMKLLF82Nu2BmAcGQH3ccuwMAA6jcVWlB9PlipCYaILGfcHWxpk10QIYeIIHaicLfgdv0CskjZcW9/A3CVHyXZ4AKd6IpWsnLpe+bJXb946y7iutwMWdAI7yytlzzKES5f+9i8Q2koBH5d/T5UQ5JDBG/aNYXjOpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(5660300002)(66556008)(31686004)(8936002)(8676002)(2906002)(66946007)(66476007)(4326008)(316002)(6666004)(6486002)(6512007)(54906003)(53546011)(26005)(186003)(6506007)(41300700001)(2616005)(110136005)(478600001)(38100700002)(36756003)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2Q3WjkrTUlIWkJhTUxjRGU0Lzh0OGNQYjFCTVp4cldvb0ZUMDFVMVUwVXRH?=
 =?utf-8?B?SHJENmdYZXkzYmIvcnF4MTJLQTlDam1sK2RqZTZ4YnA4OW16NWVNeVh1Vm5o?=
 =?utf-8?B?QnhSai8vdmpWNGgvV2lqbTIwaktmR252WHNKM0dPY2F0VjJOenY1ZlRaVXIr?=
 =?utf-8?B?Y1BrL1MvczRzSUJuY2tqdE9uZ2ZzOEhSZDM4VE9YaUk5MkNoUUhiTTRPdjB6?=
 =?utf-8?B?TDIrQjFGdWppdHB3M1ZyUEJQZStEWmdUZUV6RWxnOEw4R0xFRWhySnBxd2Nt?=
 =?utf-8?B?UTZrOUpIVjh1a1NQb0JUbHY1cjdqRTlVTkJyVkJXUDZWR1dBNm1WeFJ0RnQ1?=
 =?utf-8?B?RjlwUjViQVNxRkE1STVxQmlJOU9YdDkyVXNOTWZwd1dTLzV2WDVubjRRTGFm?=
 =?utf-8?B?ZUlNVlBGWjFIM0hScmZ1RExRWGh1ajZCVktRMFU4NFRudFRRZklKQlZWd1dX?=
 =?utf-8?B?aHN0Nld4cVFWSkxmNGw5dkIzR0hxRjRvNUtIWXVVZFczbHEvRVkwTWVMb2JJ?=
 =?utf-8?B?N2dZeUNQbE4xL0ptaXMyWlJHTVpFM2FhYjRFc0RiR0lFZlJCY2tIejUvb2hY?=
 =?utf-8?B?amsrUy80SkxGMjNoeG4zdmJLbjJ1Y01Qa0hOTjVHWGNiZGM4M0xyditGclNC?=
 =?utf-8?B?bU5PckVsTys5U01FTHA2Mm5ZbElpQ2dEaVRCb3FDWWVpMWduWFBsVjZHUHRo?=
 =?utf-8?B?U3k5VmlOZkRzcSt1NFdaRVhkTnIrbU5LYjcxKzNZazQxUytYVXhhMnBTRC93?=
 =?utf-8?B?cUNjNmRSbFdCL1UwZi9XdENJUjdGWXd4NGtsY0p2Z0FNQStJSENsUUUvSWtU?=
 =?utf-8?B?R3BMZEgwdENKUWV5OERCSHZIdFRYUlhWM1RKTGpLVnBvWWJGM1ZQYjNPQWF1?=
 =?utf-8?B?R1V5cHN2ZnZtcVZGQklWTDAyM2JsY0RyRVlzcW81Y0JGeVlYdCt5aXZrNXAy?=
 =?utf-8?B?RmtXS1FyR1FpeUxlWk5JTThqWDRBWXlVTjhVd0dZeWlxbGtwdzVuTHd0amF6?=
 =?utf-8?B?TnYrdVFaenBMUnM4R0JKUnphT2NNSFJ4ZExWQ3RmclZDSmsxZFFzSFF2U2R3?=
 =?utf-8?B?RStqWlRJdVdUbzlDeDlSR1M0M05iNjA0ckFqTVZBUEVRWEE5Y0tFY2tJWTJO?=
 =?utf-8?B?bXI4SEJKSlBKVEg3V2dYaVlLMWNVWEF1TFkvZ1JwRDVXSzdsK1NLRUtIalhG?=
 =?utf-8?B?RTlja1BMUlUxR2hBa1MzU2Z4NXBFeEhDaGFVUktVRFBpUTlJekN6cHgyaUFP?=
 =?utf-8?B?Q0ZpeXk5aHFiaHhMVUZJZjdjSlVZS0N6ZUJjVWVjS3RVUHlIS3I3TFFTRjJY?=
 =?utf-8?B?UzZBQnNGNzdMSWl3bE5uWDd4VzlwamQ5ZW4vbER0RmVaSGdudjczVTlBWHdU?=
 =?utf-8?B?Q3RlcktFb1VyOFR0eU9QeHhubVI1VHgrbWpVcVlrQXdEeHRWREZoQ00yTGpo?=
 =?utf-8?B?ZWgybU1tVUNKV0hERktKS2FCVVAxUFFqV2RKNCtuRHYvRDhoSTlUUWtPdEtN?=
 =?utf-8?B?OTRpOUY1N2tHakFJQU1BUnBKclFPTFBEeVErcVNFODhQMkYvQmc1czR6YzMz?=
 =?utf-8?B?M1JYSDl3aTBOTWRFeEtDRy85NnlXc21LNEVSK0FpU0dFWWZJd1laWFdEeHJ0?=
 =?utf-8?B?eTRVdmxrcFZjMUo2L3lTcWhkalNEckQwcllLVFBtTENRbUxtNUxzWWlkdE54?=
 =?utf-8?B?bEhUeXF5NXIwVWU4blo5WUZDK0dkdW9aSzdyajh0Q1N6bStndmhLTVhJTWpN?=
 =?utf-8?B?Z0tPT0JRRkVBc3haUy9oN3FKR3dUa0hUKzVCUFlzU1ZUNSs4c1VIaDNXVVBT?=
 =?utf-8?B?Sm0yRnNzL2pDSm8wSncrR1BnVXRWckw5VWtTM1NDQ2xLSzJVQlFrUXNabnlr?=
 =?utf-8?B?U25VMFJoVlJXK0hRT1cwZU82OXlOa0hVSjJZZzFBL3hWcnJLQ0o3dDBZMmJ3?=
 =?utf-8?B?Ry80UzA0VVVaYWZZbTB5YmN2VjlHaHU1cEx3bDJwOWhvVTg3Um5iTUxKRWcr?=
 =?utf-8?B?dlFKMHZKOGxKSCtNRFhjekkwTFlkZnA5MHNnVWNwMjVFczI3WXpJMjIwYmt5?=
 =?utf-8?B?M2FuZjVOT1htQkRDT1dHbDk5ZC8vYnliV0lpQnJTWnRBN0xGWUxITDRNR05H?=
 =?utf-8?Q?gAL/7mq05Rz0sWsdjAk6fWBb2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d48bd6cf-a30f-48ba-2e06-08db83eb3995
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 21:50:51.1245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPUEkr9qf8UKIZ5qwZI6L4nEp7EsqC3hx2EO7yKNQcfCEzIfmehBlWFY2MUraJogcL7ojBsZe37/BGAlZ66QSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7603
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 7/13/2023 2:21 PM, Dan Williams wrote:
> Smita Koralahalli wrote:
>> Hi all,
>>
>> I understand this has been in upstream already. But I have a slight
>> confusion on one of the checks been done here.
>>
>> On 2/21/2023 9:55 AM, Dave Jiang wrote:
>>> By default the CXL RAS mask registers bits are defaulted to 1's and
>>> suppress all error reporting. If the kernel has negotiated ownership
>>> of error handling for CXL then unmask the mask registers by writing 0s.
>>>
>>> PCI_EXP_DEVCTL capability is checked to see uncorrectable or correctable
>>> errors bits are set before unmasking the respective errors.
>>>
>>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>  # pci_regs.h
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>>
>>> ---
>>
>>> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
>>> +{
>>> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>>> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>>> +	void __iomem *addr;
>>> +	u32 orig_val, val, mask;
>>> +	u16 cap;
>>> +	int rc;
>>> +
>>> +	if (!cxlds->regs.ras) {
>>> +		dev_dbg(&pdev->dev, "No RAS registers.\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* BIOS has CXL error control */
>>> +	if (!host_bridge->native_cxl_error)
>>> +		return -EOPNOTSUPP;
>>
>> Why are we checking for native_cxl_error (native_cxl_error is CXL Memory
>> Error Reporting Control _OSC bit..) while unmasking RAS status?
>>
>> RAS registers will be reported on a protocol error and the protocol
>> error follows the PCIe AER. Should we check for AER _OSC instead of CXL
>> Memory Error _OSC?
>>
>> Because atleast on AMD systems we log RAS registers only on Protocol
>> errors and we use this CXL Memory _OSC knob to report component errors.
>> Is it same across everywhere? And there might be cases where protocol
>> error reporting might be native (PCIe AER) and component/memory can be
>> FW-First which fails this check..
> 
> I think that's reasonable, it just was not clear from the specification
> that CXL protocol errors are included in PCIe AER as far as _OSC is
> concerned because they are conveyed as "internal" errors.
> 
> So I believe it was an "abundance of caution" more than a requirement
> that Linux expects control of memory-errors before proceeding to touch
> the CXL RAS registers.

Got it. Also, are there any issues returning zero here, rather than an 
error code just like we are doing in cxl_event_config()?

The error code returned from this function wouldn't grant cxl control to 
OS (i.e fails to create device node /dev/cxl/mem0) which would confuse 
users when they are operating with native PCIe AER support.

Thanks
Smita
