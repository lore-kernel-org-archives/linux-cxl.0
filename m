Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA386C001DF
	for <linux-cxl@archiver.kernel.org>; Wed, 26 Jul 2023 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjGZQS3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 26 Jul 2023 12:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGZQS1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 26 Jul 2023 12:18:27 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2057.outbound.protection.outlook.com [40.92.53.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A61BDA
        for <linux-cxl@vger.kernel.org>; Wed, 26 Jul 2023 09:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mn+zdbmdLkwUx/N20O9tVJQFQw4qO7X7YHhs6V35tqKfsy1tqzTeTOv3OKdNgvk2qbXdtcUbE+ZtY7+bCj4GgppdIQ4j1U79mnvDuK+QCfwg03sulv5ACZXtzW/Qa9d6MNX8FW41S58Vks46OTe2UTAMnzQf8K6KYlbU2orZ2z8HbCAqBXFHj9FhMS4hmMDoe7kmON7x7s8iTxvD5d22yNh4x43ghL2hLNUOj1N2oQ79CX662G4+YK4sR5pUy9bRrmKH8QrgsExkdqr6fXsquo4MM1Ac0sDDxz9bo/yQWZDH58CiPKXS3Srfep68de2cuEX+dzH91rcQ7CSm/d7nsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIQ6KFkbQBIvScUJ+fn0dzaJXE+6dyTLkdqHwCBkeno=;
 b=TNsy08bvUms/Jtn98x44in5C3n6iWLspIKoq1v42QSnK22dPNmSMPHa7A2lCYnWwTmojWpSvx9t5HIXqgTaakGya5EN4X6tz7AblV5U8aUMxG9WxizHSl8U7pwkLHf2DSoNzR6JpxG3tefBFyc3Emlu8XFsGt+paAlqApYCLJI6PlRWwhMwflADRpx9f+DccFVp9flkCoyOJlN889BZjMy/R+hKAa6eUjCr197bl84Vf5Pc/L1c6fsQBjUYcL1q5WyEODaRjVvFJGa6zUIc6BNigdL/fguIFNSru95/BAfQzFCe4S4O6N0HGZts8x58XG6O2XP9CvacMWQ+ejVyMMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIQ6KFkbQBIvScUJ+fn0dzaJXE+6dyTLkdqHwCBkeno=;
 b=lLaSVzkadUzfOSiW2Ilu50zfQKE43ESpwY4SquSML08Olesb7oA/WeAiimlY5VQKpONmYWD0HaJg9Gs8BYA7Lr2weo6IMUeBz36RDy+dUG2A+9WNS/9Cb5KMsObSPzVYeMk0dlfkkYbZ0RXF4N3diETqzZKZCpDsogD/BHjlDzIRDX14XdauQfEIjKP6tWUMv9WmI7PtZHu1dJuV1v9MWf5Ry/5y0bH0YUcAjlvIMGZ9cFwcI+lapV9RBM/C5IEMvT1HC717lbMDQHjpMb/A4K4wHYxCE5vJz6Vr2OajbmMsRnlFKtmub/hsvtZ2DQyD99Ix5K4FspyGKb013ZeiZQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TY0PR06MB5356.apcprd06.prod.outlook.com (2603:1096:400:216::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6609.33; Wed, 26 Jul 2023 16:18:19 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 16:18:07 +0000
Date:   Wed, 26 Jul 2023 09:17:45 -0700
From:   "nifan@outlook.com" <nifan@outlook.com>
To:     Nathan Fontenot <nafonten@amd.com>
Cc:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and
 address space handling for DC regions
Message-ID: <SG2PR06MB3397E7869AE20F7E892E174CB200A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
 <CGME20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b@uscas1p1.samsung.com>
 <20230725183939.2741025-6-fan.ni@samsung.com>
 <1773a964-3597-434e-ca15-5ca1afdc116a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1773a964-3597-434e-ca15-5ca1afdc116a@amd.com>
X-TMN:  [06MWhy6vVW9LRmlyuoH+Yr8WdNIahm0qGxPa88HBiBAvpV+gX+mJr1Ynh5CJSpGt]
X-ClientProxiedBy: CH0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:610:b2::31) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZMFHKXXL0308YG9m@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TY0PR06MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3b9a66-4123-4ed0-1e5b-08db8df3e53d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UbKpaxPT7/qoTf9hCZ4EEuTtEMgrfyCf2gUZ+6oulweBl8vd9DuAwjO8cN9qI3wsCe1zogBZmEMUy6YAJCMZN0cE/byz/Tkfitfj+TSyP17fYNHS57p2fdhW/YVqMZqj/slptMXc7nQKu+2GZt5Kqx/Dbjy9LrpDFWKBiAJzQnafrbkRd+/3wAx237N87dNqekz8oDt+AYNxVWM/64z8rxXFW0XqzptSrJcda78Hzums+btHYyJCVw5UWYivfHs2zFpn+D4dSO/CEw7JCX4Expq/3NKHGvE8rJw5etWXRZzuNhOkFvlAgJ1A2oES4w4TseGe7mG0iXiGWcWYSfdoSGKVyk5AZ/goycJ5tbmIZfs1GKGiqLsSZyDAfO5N7Z4+dyQxQZs8kNuHJ8Uvx4q8VPUJxIYWb12kiEjOSkyvsyqso0dNMLO7a2tjQ4BSEdmoU0d6UAv9iwbr0UqFC4mRy+b4/q0bK2G1W4+QNk+eDnrBMieT+d11uGbluDt4/cqp6OXlHL0VfQyW2N09ot1subO1+fxWc9GKS9oHBrsJoupA7HwWtPxYVJe9lYSdYUNU
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXFZT2lYQUluSnFwUDRSMGdHR0xMMjQ3cWg2TTdLcWdFNGFkR0IwUHVGeUJD?=
 =?utf-8?B?bWRXNHdwdUZsTWhLT014RzgvYWYvZXRRcjJKUExyOGgyRXNDNTVWMWdkSjV4?=
 =?utf-8?B?SDNVQlQwQ01PWUR6YmJzVXIxR0NCZlUvRkFPb3lKUUpMQi9hdnJnOHRTekNt?=
 =?utf-8?B?NUNwb000eUZia0ZrdFNIb2hxNzhmdDc2K0lySVZnOXcvMkhYSm9BOFNvR21v?=
 =?utf-8?B?NkltVGpMRlhoUGZ1N3dqUHFiRU4wWGlzUExpY3QzQ1d4QmJkWFNybVhXTFZT?=
 =?utf-8?B?QmQ3ekVJckFNYWY4TXhEWktKQ1FZb0phQW1DeE90aTNBNnYzWjZpeHBoaUc3?=
 =?utf-8?B?OWw1ZUJzd1MyQnpZdWx0M0taRkZ3aE9LZm1Wc2IzeGhub2xidTQwNko5Zmxl?=
 =?utf-8?B?UHZXSkRBWUZSWFlrbjNyOUNFQ2VreTZZaSs2dEdiU3FENzQyNmpxU2FUNTZ6?=
 =?utf-8?B?RlEyM1NhandNT2lLeFVoTlJBV1dSanY1ZjhHMGJyVk9LNWFqT2tHR2VwdEt4?=
 =?utf-8?B?emREODJpS0d2WjRrRUpkclcvR3FqangzUlkwKzZwSldqR0lqQlZqU3lVa3pa?=
 =?utf-8?B?aUdSMFpPc3lUR2xNMlpXdFBFOXcxTnFDYTF0QUZFVThXdVhTbDg5M1RVRjV0?=
 =?utf-8?B?cU5DakFvblovYklDM29Od2xXZjJWdE9VZW8yZ0JDcDlBeEtHbDNRQVIvcDJy?=
 =?utf-8?B?Wmp1d0FpamdubWc5UERmNlc3OE5GcUIzSVNHNkdzbGFFaWhuemphZ1dGRmxV?=
 =?utf-8?B?VUpvcUdJK1ZKL0dTbEE2RjcvaUtCamZZNlUwVTl1WXhxQTRHUWwyOU1YeHBP?=
 =?utf-8?B?YlBBenN3My9jbHF3amg5bWg0OTVFZzJPMDRGVDcrWE93ODNkZ3FEZGQwaDZj?=
 =?utf-8?B?ai92NkZjMHZ4bklSNDgyY0Nra1JFQ3RXQWFKd0d4QzBQNytmRC9TVHU0SWdm?=
 =?utf-8?B?Tk0yNVh4c0pkSFFuVkgrdlJqanlPNCs4OEQ4eSt2aTBXMG4vV2JmWjZFYXNQ?=
 =?utf-8?B?ZVlsK2NteW5mc2RUVnptWDlMcmh4N1NpNWZmNi96eS9LSzcxR1hEcmpnaGFJ?=
 =?utf-8?B?SDBWazFwVC9YOFNvMFN5WnFGMGFIV0h1dE9FSnErbnpmL0pUb05MRXRSQVJj?=
 =?utf-8?B?QmJoZGp1dm5oVzZXR0lLRVl2eFJDU1Y4dWhaT2hESTlYNnVZSGRUMm5ia2Rn?=
 =?utf-8?B?N1RrbEFsNEtaaDA5LzlEanFybDJsTXNqM3g1SEVrOVBDVXhraENhKzB6WERv?=
 =?utf-8?B?bERBdWxSVWhlVHdCQjgzUHpnWGx5ZXNvcHhTTTc5cmFOeUFWS1RSWFJFbXRr?=
 =?utf-8?B?TTJPTWl3b2RBeEtJajhOaXdEN0xOL2Myb2xFZUowVEtITVMwdkdtYVRvMzJX?=
 =?utf-8?B?YUpCYkNVUWhtV0libmJIeWM0RjVWY2RrVlhQejMwZStuODRacTIyNVJDWlc1?=
 =?utf-8?B?KzFXZHh5T2xPVmszdVJobVJmWGwzZ1FhU3pMZVlQcUFTZldNT0NSSHJsUmxy?=
 =?utf-8?B?TUZ6aHJPR2IwWTdRa3ROMWR3RU5iRTlEWjJ5d3FNRitoUzZLcktTbmMrWkpP?=
 =?utf-8?B?UnMvSTlGM2k3QitOSGs3K1plc3ZpTWNZcU5DUzRoRW12T0NGWExmSHdEcEpY?=
 =?utf-8?B?U0RPUGMwMzhFVjJoNmw4M0FRcEFQNHdxYmRyTStxK1BoNEt1Q1RGYWpRZjJa?=
 =?utf-8?B?NDluQS9nZko5YmZIdVlBYXdoUnZjc2MzaXY1ak5YRHlaR09XY2lGVlR3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3b9a66-4123-4ed0-1e5b-08db8df3e53d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 16:18:07.3455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5356
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 07/26/2023 07:53, Nathan Fontenot wrote:
> On 7/25/23 13:39, Fan Ni wrote:
> > From: Fan Ni <nifan@outlook.com>
> > 
> > Add (file/memory backed) host backend, all the dynamic capacity regions
> > will share a single, large enough host backend. Set up address space for
> > DC regions to support read/write operations to dynamic capacity for DCD.
> > 
> > With the change, following supports are added:
> > 1. add a new property to type3 device "nonvolatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity;
> > 2. add namespace for dynamic capacity for read/write support;
> > 3. create cdat entries for each dynamic capacity region;
> > 4. fix dvsec range registers to include DC regions.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  |  19 +++-
> >  hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
> >  include/hw/cxl/cxl_device.h |   4 +
> >  3 files changed, 185 insertions(+), 41 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index dd5ea95af8..0511b8e6f7 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -388,9 +388,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> >          char fw_rev4[0x10];
> >      } QEMU_PACKED *fw_info;
> >      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> >  
> >      if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > -        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
> > +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> > +        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
> >          return CXL_MBOX_INTERNAL_ERROR;
> >      }
> >  
> > @@ -531,7 +533,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
> >      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> >  
> >      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> > +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > +        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
> >          return CXL_MBOX_INTERNAL_ERROR;
> >      }
> >  
> > @@ -566,9 +569,11 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> >          uint64_t next_pmem;
> >      } QEMU_PACKED *part_info = (void *)cmd->payload;
> >      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> > +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> >  
> >      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> > +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> > +        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
> >          return CXL_MBOX_INTERNAL_ERROR;
> >      }
> >  
> > @@ -880,7 +885,13 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> >      struct clear_poison_pl *in = (void *)cmd->payload;
> >  
> >      dpa = ldq_le_p(&in->dpa);
> > -    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
> > +    if (dpa + CXL_CACHE_LINE_SIZE >= cxl_dstate->static_mem_size
> > +            && ct3d->dc.num_regions == 0) {
> > +        return CXL_MBOX_INVALID_PA;
> > +    }
> > +
> > +    if (ct3d->dc.num_regions && dpa + CXL_CACHE_LINE_SIZE >=
> > +            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
> >          return CXL_MBOX_INVALID_PA;
> >      }
> >  
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index b29bb2309a..76bbd9f785 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -20,6 +20,7 @@
> >  #include "hw/pci/spdm.h"
> >  
> >  #define DWORD_BYTE 4
> > +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> >  
> >  /* Default CDAT entries for a memory region */
> >  enum {
> > @@ -33,8 +34,8 @@ enum {
> >  };
> >  
> >  static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> > -                                         int dsmad_handle, MemoryRegion *mr,
> > -                                         bool is_pmem, uint64_t dpa_base)
> > +        int dsmad_handle, uint8_t flags,
> > +        uint64_t dpa_base, uint64_t size)
> >  {
> >      g_autofree CDATDsmas *dsmas = NULL;
> >      g_autofree CDATDslbis *dslbis0 = NULL;
> > @@ -53,9 +54,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >              .length = sizeof(*dsmas),
> >          },
> >          .DSMADhandle = dsmad_handle,
> > -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> > +        .flags = flags,
> >          .DPA_base = dpa_base,
> > -        .DPA_length = memory_region_size(mr),
> > +        .DPA_length = size,
> >      };
> >  
> >      /* For now, no memory side cache, plausiblish numbers */
> > @@ -137,9 +138,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> >           * NV: Reserved - the non volatile from DSMAS matters
> >           * V: EFI_MEMORY_SP
> >           */
> > -        .EFI_memory_type_attr = is_pmem ? 2 : 1,
> > +        .EFI_memory_type_attr = flags ? 2 : 1,
> >          .DPA_offset = 0,
> > -        .DPA_length = memory_region_size(mr),
> > +        .DPA_length = size,
> >      };
> >  
> >      /* Header always at start of structure */
> > @@ -158,21 +159,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >      g_autofree CDATSubHeader **table = NULL;
> >      CXLType3Dev *ct3d = priv;
> >      MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
> > +    MemoryRegion *dc_mr = NULL;
> >      int dsmad_handle = 0;
> >      int cur_ent = 0;
> >      int len = 0;
> >      int rc, i;
> > +    uint64_t vmr_size = 0, pmr_size = 0;
> >  
> > -    if (!ct3d->hostpmem && !ct3d->hostvmem) {
> > +    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
> >          return 0;
> >      }
> >  
> > +    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
> > +        warn_report("The device has static ram and pmem and dynamic capacity");
> > +    }
> > +
> >      if (ct3d->hostvmem) {
> >          volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
> >          if (!volatile_mr) {
> >              return -EINVAL;
> >          }
> >          len += CT3_CDAT_NUM_ENTRIES;
> > +        vmr_size = volatile_mr->size;
> >      }
> >  
> >      if (ct3d->hostpmem) {
> > @@ -181,6 +189,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >              return -EINVAL;
> >          }
> >          len += CT3_CDAT_NUM_ENTRIES;
> > +        pmr_size = nonvolatile_mr->size;
> > +    }
> > +
> > +    if (ct3d->dc.num_regions) {
> > +        if (ct3d->dc.host_dc) {
> > +            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +            if (!dc_mr) {
> > +                return -EINVAL;
> > +            }
> > +            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> > +        } else {
> > +            return -EINVAL;
> > +        }
> >      }
> >  
> >      table = g_malloc0(len * sizeof(*table));
> > @@ -190,8 +211,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >  
> >      /* Now fill them in */
> >      if (volatile_mr) {
> > -        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> > -                                           false, 0);
> > +        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
> > +                0, 0, vmr_size);
> >          if (rc < 0) {
> >              return rc;
> >          }
> > @@ -200,14 +221,37 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> >  
> >      if (nonvolatile_mr) {
> >          rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> > -                                           nonvolatile_mr, true,
> > -                                           (volatile_mr ?
> > -                                            memory_region_size(volatile_mr) : 0));
> > +                CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);
> >          if (rc < 0) {
> >              goto error_cleanup;
> >          }
> >          cur_ent += CT3_CDAT_NUM_ENTRIES;
> >      }
> > +
> > +    if (dc_mr) {
> > +        uint64_t region_base = vmr_size + pmr_size;
> > +
> > +        /*
> > +         * Currently we create cdat entries for each region, should we only
> > +         * create dsmas table instead??
> > +         * We assume all dc regions are non-volatile for now.
> > +         *
> > +         */
> > +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent])
> > +                    , dsmad_handle++
> > +                    , CDAT_DSMAS_FLAG_NV | CDAT_DSMAS_FLAG_DYNAMIC_CAP
> > +                    , region_base, ct3d->dc.regions[i].len);
> > +            if (rc < 0) {
> > +                goto error_cleanup;
> > +            }
> > +            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > +
> > +            cur_ent += CT3_CDAT_NUM_ENTRIES;
> > +            region_base += ct3d->dc.regions[i].len;
> > +        }
> > +    }
> > +
> >      assert(len == cur_ent);
> >  
> >      *cdat_table = g_steal_pointer(&table);
> > @@ -435,11 +479,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >              range2_size_hi = ct3d->hostpmem->size >> 32;
> >              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                               (ct3d->hostpmem->size & 0xF0000000);
> > +        } else if (ct3d->dc.host_dc) {
> > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +                             (ct3d->dc.host_dc->size & 0xF0000000);
> >          }
> > -    } else {
> > +    } else if (ct3d->hostpmem) {
> >          range1_size_hi = ct3d->hostpmem->size >> 32;
> >          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> >                           (ct3d->hostpmem->size & 0xF0000000);
> > +        if (ct3d->dc.host_dc) {
> > +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> > +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +                             (ct3d->dc.host_dc->size & 0xF0000000);
> > +        }
> > +    } else {
> > +        range1_size_hi = ct3d->dc.host_dc->size >> 32;
> > +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> > +            (ct3d->dc.host_dc->size & 0xF0000000);
> >      }
> >  
> >      dvsec = (uint8_t *)&(CXLDVSECDevice){
> > @@ -708,7 +765,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >  }
> >  
> >  /*
> > - * Create a dc region to test "Get Dynamic Capacity Configuration" command.
> > + * Create dc regions.
> > + * TODO: region parameters are hard coded, may need to change in the future.
> >   */
> >  static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> >  {
> > @@ -739,7 +797,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >  {
> >      DeviceState *ds = DEVICE(ct3d);
> >  
> > -    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> > +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
> > +            && !ct3d->dc.num_regions) {
> >          error_setg(errp, "at least one memdev property must be set");
> >          return false;
> >      } else if (ct3d->hostmem && ct3d->hostpmem) {
> > @@ -807,6 +866,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >          return false;
> >      }
> >  
> > +    ct3d->dc.total_capacity = 0;
> > +    if (ct3d->dc.host_dc) {
> > +        MemoryRegion *dc_mr;
> > +        char *dc_name;
> > +        uint64_t total_region_size = 0;
> > +        int i;
> > +
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        if (!dc_mr) {
> > +            error_setg(errp, "dynamic capacity must have backing device");
> > +            return false;
> > +        }
> > +        /* FIXME: set dc as nonvolatile for now */
> > +        memory_region_set_nonvolatile(dc_mr, true);
> > +        memory_region_set_enabled(dc_mr, true);
> > +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> > +        if (ds->id) {
> > +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> > +        } else {
> > +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> > +        }
> > +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> > +
> > +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +            total_region_size += ct3d->dc.regions[i].len;
> > +        }
> > +        /* Make sure the host backend is large enough to cover all dc range */
> > +        if (total_region_size > memory_region_size(dc_mr)) {
> > +            error_setg(errp,
> > +                "too small host backend size, increase to %lu MiB or more",
> > +                total_region_size / 1024 / 1024);
> > +            return false;
> > +        }
> > +
> > +        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
> > +            error_setg(errp, "DC region size is unaligned to %lx",
> > +                    CXL_CAPACITY_MULTIPLIER);
> > +            return false;
> > +        }
> > +
> > +        ct3d->dc.total_capacity = total_region_size;
> > +        g_free(dc_name);
> 
> Shouldn't dc_name also be free'ed in the two places above where you return 
> false?
> 
> I think you could just free it after the call address_space_init().
> 
> -Nathan

Make sense. Will fix in the next version. Thanks.

-Fan

> 
> > +    }
> > +
> >      return true;
> >  }
> >  
> > @@ -916,6 +1019,9 @@ err_release_cdat:
> >  err_free_special_ops:
> >      g_free(regs->special_ops);
> >  err_address_space_free:
> > +    if (ct3d->dc.host_dc) {
> > +        address_space_destroy(&ct3d->dc.host_dc_as);
> > +    }
> >      if (ct3d->hostpmem) {
> >          address_space_destroy(&ct3d->hostpmem_as);
> >      }
> > @@ -935,6 +1041,9 @@ static void ct3_exit(PCIDevice *pci_dev)
> >      cxl_doe_cdat_release(cxl_cstate);
> >      spdm_sock_fini(ct3d->doe_spdm.socket);
> >      g_free(regs->special_ops);
> > +    if (ct3d->dc.host_dc) {
> > +        address_space_destroy(&ct3d->dc.host_dc_as);
> > +    }
> >      if (ct3d->hostpmem) {
> >          address_space_destroy(&ct3d->hostpmem_as);
> >      }
> > @@ -999,16 +1108,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >                                         AddressSpace **as,
> >                                         uint64_t *dpa_offset)
> >  {
> > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> >  
> >      if (ct3d->hostvmem) {
> >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size = memory_region_size(vmr);
> >      }
> >      if (ct3d->hostpmem) {
> >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size = memory_region_size(pmr);
> > +    }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        /* Do we want dc_size to be dc_mr->size or not?? */
> > +        dc_size = ct3d->dc.total_capacity;
> >      }
> >  
> > -    if (!vmr && !pmr) {
> > +    if (!vmr && !pmr && !dc_mr) {
> >          return -ENODEV;
> >      }
> >  
> > @@ -1016,19 +1133,19 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> >          return -EINVAL;
> >      }
> >  
> > -    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
> > +    if ((*dpa_offset >= vmr_size + pmr_size + dc_size) ||
> > +       (*dpa_offset >= vmr_size + pmr_size && ct3d->dc.num_regions == 0)) {
> >          return -EINVAL;
> >      }
> >  
> > -    if (vmr) {
> > -        if (*dpa_offset < memory_region_size(vmr)) {
> > -            *as = &ct3d->hostvmem_as;
> > -        } else {
> > -            *as = &ct3d->hostpmem_as;
> > -            *dpa_offset -= memory_region_size(vmr);
> > -        }
> > -    } else {
> > +    if (*dpa_offset < vmr_size) {
> > +        *as = &ct3d->hostvmem_as;
> > +    } else if (*dpa_offset < vmr_size + pmr_size) {
> >          *as = &ct3d->hostpmem_as;
> > +        *dpa_offset -= vmr_size;
> > +    } else {
> > +        *as = &ct3d->dc.host_dc_as;
> > +        *dpa_offset -= (vmr_size + pmr_size);
> >      }
> >  
> >      return 0;
> > @@ -1101,6 +1218,8 @@ static Property ct3_props[] = {
> >      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> >      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
> >      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> > +    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
> > +                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >  
> > @@ -1167,33 +1286,43 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
> >  
> >  static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> >  {
> > -    MemoryRegion *vmr = NULL, *pmr = NULL;
> > +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> >      AddressSpace *as;
> > +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
> >  
> >      if (ct3d->hostvmem) {
> >          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> > +        vmr_size = memory_region_size(vmr);
> >      }
> >      if (ct3d->hostpmem) {
> >          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> > +        pmr_size = memory_region_size(pmr);
> >      }
> > +    if (ct3d->dc.host_dc) {
> > +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +        dc_size = ct3d->dc.total_capacity;
> > +     }
> >  
> > -    if (!vmr && !pmr) {
> > +    if (!vmr && !pmr && !dc_mr) {
> >          return false;
> >      }
> >  
> > -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
> > +    if (dpa_offset >= vmr_size + pmr_size + dc_size) {
> > +        return false;
> > +    }
> > +    if (dpa_offset + CXL_CACHE_LINE_SIZE >= vmr_size + pmr_size
> > +            && ct3d->dc.num_regions == 0) {
> >          return false;
> >      }
> >  
> > -    if (vmr) {
> > -        if (dpa_offset < memory_region_size(vmr)) {
> > -            as = &ct3d->hostvmem_as;
> > -        } else {
> > -            as = &ct3d->hostpmem_as;
> > -            dpa_offset -= memory_region_size(vmr);
> > -        }
> > -    } else {
> > +    if (dpa_offset < vmr_size) {
> > +        as = &ct3d->hostvmem_as;
> > +    } else if (dpa_offset < vmr_size + pmr_size) {
> >          as = &ct3d->hostpmem_as;
> > +        dpa_offset -= vmr->size;
> > +    } else {
> > +        as = &ct3d->dc.host_dc_as;
> > +        dpa_offset -= (vmr_size + pmr_size);
> >      }
> >  
> >      address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 503c344326..1c99b05a66 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -427,6 +427,10 @@ struct CXLType3Dev {
> >      uint64_t poison_list_overflow_ts;
> >  
> >      struct dynamic_capacity {
> > +        HostMemoryBackend *host_dc;
> > +        AddressSpace host_dc_as;
> > +        uint64_t total_capacity; /* 256M aligned */
> > +
> >          uint8_t num_regions; /* 0-8 regions */
> >          struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
> >      } dc;

-- 
Fan Ni <nifan@outlook.com>
