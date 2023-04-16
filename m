Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F61CC77B72
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 01:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjDRBDk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Apr 2023 21:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDRBDh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Apr 2023 21:03:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADC93581
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 18:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiP/1FtI6Muto3wupjFeXab6PckjQXMib5PzKOhp4APhHvOq8VkBW1ksJUc38dfECHwPCepZB3Sa4lnPofsS5ALKDtx/idoHUYhgCHJl27pQNh3LK8MmjnILXRZzMLyDSn/nQZ5uXRCEI14s7fH/uA1QWOWDHF7sDBo+32X77tmv/rsc48THHkgbMNyz28tPF+2ZJIov32J/hisc5itB7NtephV7VBhmBBPMtH4dKtfKxjKbTaF/IR6kOjFlrPMNAgqcenqJb1u+T3HbMc5cxgKccGm7V9WjUTuxFtptIfczCTSL2VXEKYext8VIWSyaHisp1DaZGF/KKcSD+JXokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7//NGd8JCnegE+N1j1RHFybHqjZoyO7p76YpGP6tKY=;
 b=DHCDpCVPXZE2DyRc+a9lfWT0BwxvsX1H1bJmjDXKm8PWBWOBZPwWQz9XNkRhLRnSx7Zv48xor6MuNXbVlK35n8HnNsXd1Fky9jA6zZES56KzwiVT8AH6aRg7r11jWrD1VwtVweMwaXZaY3voz0YLaLPND9hbVqyxQSPylBmEvdAvIURMqirqD1hGMwVehUwDZEFG8dPq/srALMwossKc0GbSmHX6EtNiUB+7VAtfsKjmlv03j5G58kFw97oLQCzdk2ApBTM8ddfxkD4yZZLVJfvboswRAJEPs31WEf/4cNIdTGaWkE5K61mqR3M4koKCMltEpqHf684vPShvEHgsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7//NGd8JCnegE+N1j1RHFybHqjZoyO7p76YpGP6tKY=;
 b=xnPKbRiLWNyaL+QXYx3qMDuwGj6zwPnDHlCinnvazyO1kebKy/3rGTIw+WZnmmsbzoVzDiJ6uufo0WMsVV89LQ7PeBTfaoMw5Z8ilE7X8r1gYxy79iuTFTRRATTWByjbj5OJ1d2CrFCbnk4XRp03rdD3e44UVcSva9iKEjgR60M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB5971.namprd17.prod.outlook.com (2603:10b6:8:52::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.45; Tue, 18 Apr 2023 01:03:23 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::7b97:62c3:4602:b47a%7]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 01:03:23 +0000
Date:   Sun, 16 Apr 2023 00:05:15 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <ZDtz++B25suuoYoY@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <ZCRhhUDcmypVKu0X@memverge.com>
 <64250e45bea49_c722294c2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCRzh0VLSVF/7jya@memverge.com>
 <64252d214f0b_c7222942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCUPlnQYVRCumy2O@memverge.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCUPlnQYVRCumy2O@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB5971:EE_
X-MS-Office365-Filtering-Correlation-Id: c7960d28-a2a4-464b-462c-08db3fa8b51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5WB12yXMPSxSbdQn1I9QeLhXFS8etq9emSSZtevKfDx8QDqHjftxWY1zaqmi0eHMxMBrC2T1b5m3ImdIUiN/bcfdbtqaoLfOuXf2G2D+PaSXVFuuygg6/oktpWK+dp3Xt30aq/l7RAQOM7mq2yk6H4xT8uplaiNjILRfnReaE7PfAj3Bfw1dDHNSIrGvY3lGWtwqugS1mVECcrXBHMPwzJrmkjBmKCyR8t19vNbamCeOtdML1Iq/+6sCrBV8iq79+zQd3fAV6fInMQ6N+C1WBHWZC+81m48y5xbDyE4V4gXDRklOUTjBzfoHE/7g5kuU5440OZVhy+DkNn9woAt9SYITu77mZfhK3AXcmghijc8OvMoYA0L9L4iWvu5gCF1+HvUDYNgLECxIVdRNPC09Kd1T1nka6yNVJTNl7l7ToGPazKlaFwMQKkxaYujOvAZhQ5X5R6bQnnVL9rZfMT3WnIu1lLG0bxlsYNARAV2SVmX8TxoZVHufX6KRFt18/OT9NcUhL85VN6xWspz10isrU0z1zL8GdXj6RlzQYNwH+tm3b1WHdm9zUUC/mZuZ8+Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(39850400004)(136003)(396003)(451199021)(6486002)(6666004)(2906002)(38100700002)(478600001)(83380400001)(186003)(2616005)(6506007)(26005)(6512007)(36756003)(4326008)(5660300002)(316002)(44832011)(66556008)(6916009)(66476007)(66946007)(86362001)(41300700001)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yy91aWIva3JHRE1RVVVvblFubnk0NU0wZFRRTGdpcVkvRU1OcjNXYUUxMi9a?=
 =?utf-8?B?dHZWMGMwRURyZXNJVno2aDRlL1hpT3A5QWJac2JiSkFNUTlWcEJ3YVNhYzJw?=
 =?utf-8?B?NnRwUDg3VmtDdVNKQ0FpSndBRGpTQkhTUk90NVF6QVk4NHdFQ0FMYVhRRkRj?=
 =?utf-8?B?czlieUlteU5iaW0yanZndTE5MWRHbWJTT2RGT0w5aU8vanZpTGFZQnJvNVFa?=
 =?utf-8?B?c2ZQa25iRFV2UEVEVnRLQnYya1Z1OGxEY3FZM1QwZVczK3VTVTdBVkdReGdM?=
 =?utf-8?B?UnNCRTJ1SUs0TytPeGE1NExCTnRjK1p4UHBjWjJrV0krQndiMGp4VXVXYncw?=
 =?utf-8?B?cWJodTEzMGpQQlIyVFdVaFdXV2VwcFU5VFBlVzFkOXdiaVd4TWNYT1NKT0Zw?=
 =?utf-8?B?amVuQUV2V0NsQlkvWUwwNkhqak1yTUhER2F4ZmpFbElUQWdGYWVzNi9lV0Q1?=
 =?utf-8?B?RDlQNnZTR0V1WWlpK1pwbnBzdkorMXVTSlROZVYvREdXbVhQSFFoaGJvUkto?=
 =?utf-8?B?NXJBSTdGZkpKcTdUaVJKd2ZJazNJMUl1TlNVblpsR29lOG5JMDgvcituN2h2?=
 =?utf-8?B?T1BXSFBTRGVBZVRCOFJPU2krTGhjQXhNN1pCL0V6ZlA4VkFqVEpDSC94b09v?=
 =?utf-8?B?Mm95NkZnVGh6cm5scjFBMWJwdDhPWnNOd3lma0RueEZsbWhFbTBHdkdQU0p5?=
 =?utf-8?B?ZVpEQ1E3K3BwZTBtVjlxUENZSHlmakRJWlB3cDRHR01ybGpQbTF2SmdicHpF?=
 =?utf-8?B?dUhPVHdwQ0gxQy9reDdiNnNWekhWVTVtbGpGanpTbXFybkc2Z0wrQjh5a0ty?=
 =?utf-8?B?cE5OZWZNYUx4dW1tYzN6ZHhWWVN6c2J2K1FRTEt3N0l0OEJLa29FUldCVkE0?=
 =?utf-8?B?NmdWS2tWYlJlRjdFemVNU3hVWnVMN3BaK0hZbXp4NFUxK0tZaEhkN2c5NmNT?=
 =?utf-8?B?MmI3VnFTLzU3aXB6cTZJTGprSUFCMDdnckJRci9ad09QZ3dCRzg0L0tYcFlH?=
 =?utf-8?B?dnFMY3VvcklmVEZGNkFpWDFTWUFVTDlpMXd2aGFDY2hzcXlhWDNrZFN3RVJk?=
 =?utf-8?B?RFN2V2l5NkE3RUVxRlk0QjNhK25naW9UbVVhUjh0bTdtSlpudi8xZmtiOFNx?=
 =?utf-8?B?S3I1WE5HemFHbmNLSm1uNmExN2FRUytES2xZRDdUT1Y0SGpEZFh1dWJQN3dN?=
 =?utf-8?B?Qko3OUgvU0w0SlNQeWZDc3kwNjRyYm5IQjhlVnF2aTNSNWRoVExPY2MxRGVO?=
 =?utf-8?B?bFROS0VyRzBXSmE0MFdoU2ZQRCtMMUxiNnN1U0MyUzY0RTl5eEdQTUF6TVFj?=
 =?utf-8?B?bHFURWMxQ0NJa2drWEkrNG1QekZWdjVJZUUwRzdoSGdObWExV2pHaWhyb3V5?=
 =?utf-8?B?dG1sZzF5aG5TcStIRWZwaDlNZnlaSkZOT0d4L244Vkt3eDZnb0pVS2FLeXhi?=
 =?utf-8?B?Z0ExZlBsYklRMEJWanF2VW1wWEpER1JTem5Sc3RaYzRUODdhT2lqcUZ2VjhQ?=
 =?utf-8?B?b3ZWNUFLMm5FNXg0dWd3TzVvMEJhRDhRaGRlTkJzcWlWczVMbWZQQjYyS0dX?=
 =?utf-8?B?Z0cwaEg4OGNRZ0hCMTFiaFhtRmhjeFgzODZjLzUvbFRyYzkwZTJoVEt0dW9p?=
 =?utf-8?B?VDBUWk1CN0hSU2J0Qk1tZlFjaXdvK28veUE5UjIvYVVBaS9wWWJrVUJmQkc2?=
 =?utf-8?B?K0JMNkZrbnEyWkZxYlExV0xSMFFnWW5Cb0h4TkJoSzIxVEY2a3FPY2xldE1N?=
 =?utf-8?B?b1JkNC9QMzF1emMvV3I1Z1lnbGdiTVZLOGdKdTNjaGlGVHliR00vSUxHelFN?=
 =?utf-8?B?Y3ZXZ0R2U1JmU0tmV3R2WVp4VDFQbDFwOTV6TkkyQWh4QlhkbHY1TjRZNk1Q?=
 =?utf-8?B?MURBM0oyWUNJaEE2TDhIWVdkclR1TDJzRTB1ZmhsdDhNc0tlSi9nSkIvcFVi?=
 =?utf-8?B?Mmw0M2EvRVZ6YUd6Q0lvYU1OMnZwSE9ZUm5ncjR1Q3NxR25ZOG05NHFpZ0d6?=
 =?utf-8?B?Tzh0Sm5KaE0xVElLTlFKc0xUeTMrdEp3RVFwb2dFcExZVEtwYUNZNjZnVHVr?=
 =?utf-8?B?bS9yUUErMDUraExrS2F6UUR0eE9YTHVXWkFhWnVLTFh6RWdkdTc0N2NFSmg2?=
 =?utf-8?B?d3lTTGpvY2R5RmdmQjhXOGJNb284RzNrS3IzSXRzNHFQdEMzL2VWTk5GS1c4?=
 =?utf-8?B?cXc9PQ==?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7960d28-a2a4-464b-462c-08db3fa8b51a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 01:03:23.2707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fj8lo8+DBDIkVOWx57lX8GFUrkST6aoPgRyOOvdMLq/CO1cq/U+ukkDtZhgBLygn4ysI76bGIlQCzgbTc4ZnBhNVdoN0vNOZNdCUJVX2fIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB5971
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 30, 2023 at 12:27:02AM -0400, Gregory Price wrote:
> On Wed, Mar 29, 2023 at 11:33:05PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > On Wed, Mar 29, 2023 at 09:21:25PM -0700, Dan Williams wrote:
> > > > > Is the DVSEC Range Register expected to be programmed by bios, and are
> > > > > not being programmed correctly?
> > > > 
> > > > This debug experiment makes me think perhaps the *device* is at fault,
> > > > not the BIOS. Perhaps the device accepts writes to CXL_DVSEC_RANGE_BASE
> > > > to set up the decode as expected, but reads return 0? That's the only
> > > > way that I can see that forcing that offset results in successfully
> > > > talking to memory.
> > > > 
> > > 
> > > Oh, i meant to add that i tested whether the memory is accessible via
> > > numactl --membind=1 with both memhog and a python prompt, and things
> > > worked just fine.  So memory works.
> > 
> > One other theory is that the device is correct, but the platform CXL
> > window accepts transactions at an offset and then removes that offset
> > when transmitting the address down the CXL port. So device thinks its
> > decoding 0x0 and never sees the offset removed by the host bridge.
> 
> Wouldn't that be against the spec?  I thought the device intended to
> receive HPA and do its decode accordingly.
> 
> Otherwise you could have multiple devices programmed capable of decoding
> 0x0, which is already the device address, so there's nothing to
> "decode".
> 
> I'll follow up as I learn more, this is concerning.  Certainly explains
> why every time I switch hardware nothing seems to work quite right.
> 
> ~Gregory


Follow up on this:  I attempted to actually write Memory_Base_Lo/Hi with
the appriopriate values, validated the write went through, and then
utilize the memory.

This test lead to a total system lockup, implying a major bus error
and/or device failure.  No stack trace or any indication of exactly what
went wrong - but it's pretty obvious there's a device issue.

if you remember, my initial test was to simply shift the base to the
base of the CXL Fixed Memory Window:

@@ -342,6 +344,7 @@ int cxl_dvsec_rr_decode(struct device *dev, int d,

                base |= temp & CXL_DVSEC_MEM_BASE_LOW_MASK;

+               base += 0x4050000000;
                info->dvsec_range[i] = (struct range) {
                        .start = base,
                        .end = base + size - 1


To this I added some writebacks to the registers to set them what they
"should be" (i.e. what the BIOS should have done).


The other thing i noticed was a combination of DVSEC flags that seemed
interesting:

DVSEC CXL Capability: c0de
Mem_HwInit_mode == 1  (harware + firmware on device do init)

DVSEC CXL Range 1 Size Low: 804
memory_info_valid == 0
memory_active == 0

So this appears to have been BOTH a BIOS *and* a device issue, but we
should also be checking these bits before using the info from these
registers.



Something to note from the Spec: RCD Discovery (9.11.6)

4. If Mem_HwInit_Mode=1
... snip ...

- Each HDM range is later exposed to the OS as a separate, memory-only
  NUMA node via ACPI SRAT.

— System Firmware obtains CDAT from the UEFI device driver or directly
  from the device via Table Access DOE (see Section 8.1.11) and then
  uses this information during construction of the memory map, ACPI
  SRAT, and ACPI HMAT. See ACPI Specification, CDAT Specification, and
  UEFI Specification for further details.

It also sounds like trying to place this device in dax-device mode isn't
really the intended use-case, and if that's the case maybe that should
be disallowed?



All this considered:  It's still head-scratching why shifting the HPA
read from the range register successfully produces a "working device",
but I suppose that's the definition of "undefined behavior" :]

~Gregory
