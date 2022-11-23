Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B874C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Nov 2022 08:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbiKWIj1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Nov 2022 03:39:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbiKWIj0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Nov 2022 03:39:26 -0500
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2127.outbound.protection.outlook.com [40.107.241.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B131DF1D91
        for <linux-cxl@vger.kernel.org>; Wed, 23 Nov 2022 00:39:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwaL4vqG6lFGbgkjbNsKoqQH26pVe2uvJz/3Ado4tfJtyd0l2BoYcVvRjzCDKVj533Rv733HnpFLbjQpSOI3f/YM2maSW1XAjV99fi0fl4GT00V0qEZXcB7Ik6O/PuE1yj9OmKG7CnHF6kEzZfwsehyvFKu/PixRaQNML1P5k8MOvfe8dUCR6DlfSUosEK8Vgn/XhUqTwDaesJ7XGLFgWgdoi6qAE0b81jOtoUM+ybmwDYrNQ576EabkdXrPJquTWGyg1OLGKaOU/x3zT1DcqLManC51gPM8eHr3ayLDElHYPaVkuNrodKxAGgCBH0IPajTyJBJrBbdz0y/crI/l3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJVmxtE9FXkkcRzJHYdfc7k48UtDuYiO8IWBvFbh7d8=;
 b=kQ5AgbHP837XMHCo9Q9FPbNUfCS1YSOZvqbBXJ5BaAeI6QqDttpf6OqMiDNETQgteyc+n3saBGbOFp68H31t9ox6NzD9JQWY+hAaw8AbxsBeBqMbFpxIUF3/0Vemt91kybot+fIgZcdtbD89PcYOZz1b2TcBw7nTAIvvW0s9OxRdUeqwhBVbU8OpS1KGegNCLp99wsKZbmgXLftUGFK+IZFSoTzjLkn46KDFJv6Xt8lSlZNurSMYiMpoQnzeZriw+/xiKL96Da3X8MTzEpa39Mtl6UgThZ1GfmL4+C1yZaoXmg6Ec2jSURycNZ7wKexJC85cPP+BE8HAxxIZnOthog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sasfermat.com; dmarc=pass action=none
 header.from=sasfermat.com; dkim=pass header.d=sasfermat.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sasfermat.onmicrosoft.com; s=selector2-sasfermat-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJVmxtE9FXkkcRzJHYdfc7k48UtDuYiO8IWBvFbh7d8=;
 b=UeD1xZyZdWtlylbcRRnqMeX+VlL+Dl34H+JSTqnTjC66KpDA1mvSVqY1+R4sQSrxPLgEZhAy/1dZEgHdzWQZor/hXiTvYrezqBjNr+jZ5QIgnb1/SZ1s33BWZljhWWPSKHGFJdJMU24VxpWg1gsfjUKsA7S+WhGLWziF6pLcl1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sasfermat.com;
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM (2603:10a6:5:10::13) by
 PAXP191MB2120.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:274::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5834.15; Wed, 23 Nov 2022 08:39:21 +0000
Received: from DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::7d96:5b85:595b:a42f]) by DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 ([fe80::7d96:5b85:595b:a42f%4]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 08:39:21 +0000
Message-ID: <59f5b8d4-2b03-dfc3-8ee3-6188b5f0b050@sasfermat.com>
Date:   Wed, 23 Nov 2022 09:39:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: Prototyping on CXL hardware
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
References: <40fbb3ef-ccf5-bfbb-675c-861948beba56@sasfermat.com>
 <20221122165331.00006923@Huawei.com>
From:   Julien BERAUD <jberaud@sasfermat.com>
In-Reply-To: <20221122165331.00006923@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0200.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::7) To DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:5:10::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7P191MB0377:EE_|PAXP191MB2120:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b86d5e6-3a79-47cb-9a76-08dacd2e3713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g2FFwYvEO4Jo6k0okydbnLCTpOSuxhn5ArQaLBHoha35R9B1jVtrOsO246wFb+hGyh6Q1RuZZirP4MGP4I2de6GD5y0siCQ0O71WpMsQgtlfNsFy22AJj1RqG8lA4HVdz79t5IYFETIc/ZVfd9qNSYuHLtYVbn7+Ls1N77QHMTLM40jzSCMIHqLFSkSilJ1Hpf6sPBqibae/fYCc6r+Me2fM+cE46GdsLwdcNCwLa1XlWfkYDR6owSRpdbuPYWzXCIKzKQpCIuFsItL1EQREqz3bZsia8bxjw6TnoB3qPwe/Mv7VZAdJnPY8uVy1ppH2rDQX5XLTlaDJ5h94mnRwSmlwA2VQppveH1p2VghGQhbNwpfJfSO0L4vLTZxFP9l60stqqnEeiCxxfCZFUjksurY4AodmZ9ZxZ3FaennLGutjFcAMrh/Q4USFI+pIRjNepNUTV3Me5jQGa3NCES9+U/9bCHAe/EEThQWc3hRkaNRcRyEyFGLEegImbQg/B/6jemf47tusljdnrXFqZMIdkv/eoHHIe6yvoupNRh32tBEshb3xDaVHszIVOZXknpEhe4S+fVV0Ppl0uii6B1Fs2wE/mWZs0QUclBE4mVLJVMgamN3G038spzmpTbEwxo+LZTmN4IB0N2+Z7MsnRc9FONxeZ/+T1ZRRK+1OqjaPiDgmlBvzhI58v1Z482g64fWCLEUZPd+tGjoh4DY0rG3v8oUx3xq+kysNVf3HngxZnLPJM37aeArYSCm0CoiOfG8dXtHcfsTcdBPO8YtuOloO+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7P191MB0377.EURP191.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(366004)(136003)(346002)(39830400003)(451199015)(86362001)(31696002)(66556008)(36756003)(2616005)(186003)(41300700001)(66946007)(66476007)(8936002)(8676002)(5660300002)(478600001)(6666004)(26005)(4326008)(6486002)(966005)(316002)(53546011)(6916009)(6506007)(38100700002)(6512007)(2906002)(83380400001)(3480700007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9FNzVZSUxWTnc5cE1zcmJaWldJdHRBOE9WNmRlMVhhSm82Qnp6UjRkRzRX?=
 =?utf-8?B?dnhJb1pUaG1MUEZuVjBnUkZsalpUR3ZEcHhrUDhLeDVlTXZ6cy8zdFYwQXll?=
 =?utf-8?B?OEJ2aFdOck9GZjdKQkkzcEdabFlEcnpmMGdjRzZ4QXhKUllHcEovSnU4L3J5?=
 =?utf-8?B?aEZ4a0RBMExPUnd2NE9rMStTZGlqTTFHRHIzY1pKUnlxYnlxTVp0UDdxN21P?=
 =?utf-8?B?dm16K3g3TklnSXZMMmVaTkZCQWFva3RtRUxoL05VQTJPTEVJUkNCRlpsUTFL?=
 =?utf-8?B?QWNFeHZLY2hIUHJwSk5nelZzelhqQk1DNE54dFhiOU15blpuRlNQdjNuMCs3?=
 =?utf-8?B?Ri9JQnNSWU5FdEpKQk13WGUrMnFTaWV3ZWE2TXNxTWlTSDlkL0syUjlDYTBE?=
 =?utf-8?B?TkVXbENmY2ZsL2tWMGx5em04WExzWUg0ZFoxK0ZDSnk3bm13eCs1YWxiRzFN?=
 =?utf-8?B?c25FeGY5cVRvU2lodGFjYkNkL2EySWlZWW1SaldhSFlpSFVySkVkaFRUL0lw?=
 =?utf-8?B?WE9YcHllcmhrSHJheTBkMjVpeFFGa0cvZ2NVN2pPU0RDcGxWSTNZTzdIVnBp?=
 =?utf-8?B?dE5md0U5TUxqU3ZiUnBhNUJqcHB0cXEzZGhFRU42ZnBZWEdRbEcwZkk4aHhD?=
 =?utf-8?B?R1RrQ2NCOEJJcnNtb3V3T0gxRjlZVU9mWTk4N200R1FnaVpTRWNvUGhXYlJN?=
 =?utf-8?B?WlNpR2JldkRYam5zNnQ3dWRhMFhiNjd6T2J0YlV6eXVlQVd0SHk0WVR2TTNR?=
 =?utf-8?B?UjVyUE14U1E3YlFMdlZPdEZIR3l0OWNQY0EvZ3RwNk1yMVR4SisvOWxMb0xJ?=
 =?utf-8?B?d0g5ZHF0RjlySHRKUytQQUQ3eWt1eXRWNzc0VVhUZ0lBUkJTTkxGVlZ3bHNv?=
 =?utf-8?B?VmIyUjFuN3lwM0E4RGl3MFNrejRzakY1TEpXYUFZYnZ5N3FXQ2Z3LzdNbzAx?=
 =?utf-8?B?YmsrS1poeHlGVlZGeWk5cTlEV1l4UzVIQlk5UHRQV0NjdzVOaVhVRGxQVGNK?=
 =?utf-8?B?NVVCdEEvVU5zWDF2MktGUk5XbEtRSVIxYWNPTnEzTmhaZ0V3SnlGV0dOaEJV?=
 =?utf-8?B?YitFT0JtZ3djcCtPMmJUNDkwRmdBTEFyeU14YU90UXpFMzFjQ3ROMDc4VHox?=
 =?utf-8?B?L2VVN05yTWdJVkNtSEt5b2pxRW5iM3ViYWVnZjFGSFg2M3NJaFYrNjIvSmFu?=
 =?utf-8?B?dkFJMkljdHpMNTU2ZkZzT0F4TzFxRlhyREJJY0h3cGRkL1JLN2NJU0VRYkV1?=
 =?utf-8?B?aFFEeXpJblRnd3JCalYzY3hvaUpaWmpPcHFqQXJ5UndpUXdRMjIwZ0Jod2ky?=
 =?utf-8?B?Sm9IaytrVTJURW9mTHlDUDBpZUhiSHZhUTM0WWhNbVJ0T2hUZmlUcDIzZS8x?=
 =?utf-8?B?eTU1c3Nld0tianBQUHE3RXlBanR0NzQ2U1A0SjZCZHRENFVPYmFEazN5T0lB?=
 =?utf-8?B?OFBPTngzVTJKM2s3amxoZXJtbjdDc3RINlZaUmVzNnpibm9IMy9la01XVG1U?=
 =?utf-8?B?czZpNE9SbjVnemVKYXpjTDZaQ0NzcDduZ0c3Y0ZiazVBaWdGYXdPYXFUWXRR?=
 =?utf-8?B?WkVLZHdLM1FqckRwbS9wVFdteFh1SEkvK0Fid0lTcnpvb1ppWTZLTEE5Wldq?=
 =?utf-8?B?SUlhb01DWXIzOHNWZnh4ZWxoWXY3U0kzREFuZFpIanMwSUw0L0p2RFVVVHhV?=
 =?utf-8?B?Y2RjOEhsaEVKektQekhhVUNMM1ZSKzJyZlJSMVF0K3VRL0tjMUxiWTdDZU12?=
 =?utf-8?B?VVhUMXhDRHUrSzdCRXhRNUF1QlV4RUpveDVRc1BWdXlvQkQxUVl0bUlSTDVP?=
 =?utf-8?B?L1dDNDZMejJEUkFhNURWclpCaDZ3b0lhcDJRV2c0SVVEZjZNNC9BVnluNzNx?=
 =?utf-8?B?UHBCZEw4QTRvOTRVbkcvdExsS3dBcitQVjkxVk9GUmU2Ly9EUmxiWHlieG96?=
 =?utf-8?B?RWlYWTBwLzJhbFBRcW9WN2UreUI1ZUdBQlNsbkppRGxyMGplbGNmaDk2am9O?=
 =?utf-8?B?Q0hyMnI5K1hFN3FqUy9SbVUzVHFZVVArUm54RjduWXVFd3g2bGdlWFRJWEpj?=
 =?utf-8?B?djdJa2pBZVp5OGdUYUd6NXd4YzFISmQ5MmEvQ21CbURXT0pCZmRVWUhaRE9C?=
 =?utf-8?B?UUtzVERQRWxHNzliS1J6a0dRZkEycDVMZnMwU2ZWWHFSMUtpellHRWU0NFoy?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: sasfermat.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b86d5e6-3a79-47cb-9a76-08dacd2e3713
X-MS-Exchange-CrossTenant-AuthSource: DB7P191MB0377.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 08:39:21.2410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e414563a-f0c0-4cc4-8c4d-f4cf6cb1255f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPcRYLNC38Z9T3mhwdNsJ41pRD7ZQTNjoef82d4dRI5R0068f6ctl9IbBj1vHUrk72mQo20FeXwbsl7KCi22/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP191MB2120
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 22/11/2022 17:53, Jonathan Cameron wrote:
> On Tue, 22 Nov 2022 10:54:52 +0100
> Julien BERAUD <jberaud@sasfermat.com> wrote:
> 
>> Hello Everyone,
>>
> 
> Hi Julien, Nice to 'meet' you.

Nice to meet you too.

> 
>> I'm currently trying to prototype with a simple use-case on a CXL type 3 device
>> directly connected to a CXL 2.0 capable server.
>>
>> Since I have seen many patches being integrated in the mainline kernel, I am 
>> running a 6.0.1 release.
>>
>> The init phase of the drivers fails with the following trace:
>>
>> cxl_mem mem0: at mem0 no parent for dport: pci0000:16
>>
>> It occurs at the first iteration of the loop in devm_cxl_enumerate_ports 
>>
>> The previous steps have been succeding as far as I know.
>>
>> ---------------------------------------------------------------------------------
>> So I have a few questions that I hope someone can answer here, I am sorry if they
>> sound naive :
>>
>> - What is supposed to fill the device's ancestry, and what does it means if there
>> is none ?
>>
>> - More generally, is a CXL type 3 device directly connected to a CXL capable
>> server supposed to initialize correctly on a 6.0.1 kernel or should I use a more
>> advanced branch ?
> 
> To take a lazy punt in the dark as it end of day here.
> 
> Do you have an ACPI CEDT table and required ACPI stuff such as ACPI0017 in DSDT?
> Otherwise the root of the created CXL topology will be missing - I haven't checked
> the code paths, but that might well give the above result.

Thank you very much, I was kind of suspecting this would be the issue. I'm far from
an expert on ACPI and other firmware related topics and I have to understand what
it implies on the device (we are developing the type 3 device) and possibly on the
host to add the CEDT table and "ACPI0017 in DSDT". So I'm back to my homework here.

> 
> There are a few fixes you will want on top of 6.0.1 - but those are all around
> region creation I think, so you aren't getting that far.
> I've not been tracking progress of those. Dan, what's the current status?
> 
> For reference you could take a look at the upstream QEMU (very recent needed as we
> had a fix going through on x86).  That should work and gives you something to compare
> with when bringing up real hardware.
> 

It is exactly what I am currently trying to do. I'm having trouble finding out the
proper set of options on the master branch or 7.0.1 of qemu but I have been able to
boot with an emulated type 3 device on the (rather old) cxl-2.0v4 on
https://gitlab.com/bwidawsk/qemu.git.
Again I'm back to my homework here, glad to know I'm kind of looking in the right
direction.

> Jonathan
> 
>>
>>
>> Thanks in advance for your answers,
>> Julien
> 

Cheers,
Julien
