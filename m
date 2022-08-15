Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BA70C00140
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 02:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiHPChC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 Aug 2022 22:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiHPCgc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 Aug 2022 22:36:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E428A7F119
        for <linux-cxl@vger.kernel.org>; Mon, 15 Aug 2022 15:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660604121; x=1692140121;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eAJQF3+1IDHTATO7iW3InDIibL40VaBeeiznfCicSpI=;
  b=jo/QFsfoOv5qskFohR450/PkM1txsI2Bq0iV9da5rcCk1MguJVpXsRtx
   vo5xlamsmjq9S8KCoKYdDZp0BtQEFqqlyRbxYwT2Sy+5khtSB/w8AazJB
   RovRots33HgQpqQcllbBsvFEzAwTSKPEpEvM4P/5z7F/EBWrtxrPARSXP
   YXT0D2bdenMWj2EGkCgSRcFxkHOIc21N0ZD5TYW2J1/GSK7jDR3Ybx6PF
   g830JE/HGykcs/0yBGtWhXNzvL+bTteCCcPswdhDnPVuZHF/wEW9lEj3q
   Nqr9cS6rDiBpUiB6+MGB6nqrLcgKDNakIHWp+jFBBA02p1pbnmC9ocR3K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279035193"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="279035193"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 15:55:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="934654699"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2022 15:55:20 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 15 Aug 2022 15:55:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 15 Aug 2022 15:55:20 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 15 Aug 2022 15:55:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fjr2E3vlKvLnVGzkcwZuhzn33Hmir1LqEp4EnIncB8x1jyIO8ubx6VrN1OLlSlfpAK3w2epNV/+PNNStmvUZORpUW1ni64TPyiKwgMk7gipDiBZXoAUCCK1J6s+BqKDsIP9glMGByKm9YwW0xq0vEULUlGDM83p2jBQlS+MTEOeA4Rq39GoGakP2tbpupQ3W8N4LJPv1M4NUzOnHCTv+fvGMhfzbH1keK7Iv+PfBr79ZhDKeC1LnZW8rNujZlCi+U0ZioUNeKLBAcVwcKD8QsPcEdJLaA+m1/g7NIgfjSFj3Eifzn7BquSvVLx8/MKQG0JbgJRE1K98nPstHOORCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MJy4ctPNCzjY35UYeLt9gjT1nyvgV3T0Ae73Za/FWY=;
 b=D6vw25R/BCrmhNQAXTnhho8/gAUP3/If6Bh2jkhVF7Asx6wCQ+Pjvqp44iwzcyEPq4CEHK+rqhGmV0xJXbxA5gkczeTn0XHXpJ7v6gMiYz5vuUNr4et3+Ep6fIJvNHdRYNOaITO26vbHh/v5Jc31d4i7ZEChfhh0kqYR9QFXYjYDxcMuvBwhFV2TJp5mtBPgUc8UP1FXAWMrzijndOuzuyzwy2mzaxQJvxIH6913NFYm7bk5EM4QI23w3lG7Gh70nSqcpn6PQb2rPElLaIJVUgAxuFmkwaEybvXGjYox5bYn2S68WTtuyzxRYxFLeOrBOTehAsM/lfMxPg+9klZsnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SN6PR11MB2829.namprd11.prod.outlook.com
 (2603:10b6:805:62::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.18; Mon, 15 Aug
 2022 22:55:17 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 22:55:17 +0000
Date:   Mon, 15 Aug 2022 15:55:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Bobo WL <lmw.bobo@gmail.com>, <linux-cxl@vger.kernel.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <62faced380b00_dfbc129494@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <20220808133727.00001171@huawei.com>
 <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
 <20220809170825.00001b61@huawei.com>
 <20220811180857.00005e67@huawei.com>
 <20220812164403.00001654@huawei.com>
 <20220815180444.00006bdf@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220815180444.00006bdf@huawei.com>
X-ClientProxiedBy: BYAPR11CA0096.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::37) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d108bd6-c9ea-4740-ba38-08da7f1138ef
X-MS-TrafficTypeDiagnostic: SN6PR11MB2829:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fO6tN6L/SBqyObYRkJKWNAPwEA3ponoVS8e7vWPDgPYmWCXii+ALA+SOFO/tdJHQppjKjcJrDsK+AkPlubBuh4istKMdAs82zhCv+mWJMUet/G3Txr5h20TUPYERvXUyg3u+6omF3gNmockHTNoXLHRPy6E/W9kWs4Q+pULIFzcTgF+oGneA5ANTcYFJ9hTEFvTZ4EEyVFAYRut33dsuVcf4LlxuX/qXiY8z02fjg9Jsh5qqqHbLH8vAQCquym0qLNfAo8PLXfSTZD678HPOgIye3lnObMiO7p1/eSUp+nKYZA631xEQ7KHRGsKUNmZsEfXoD38YQ36fXw/c0GUPCHtCtR5g63vPBIzMfNcArcL1zAF5qEs9Ta5Hh0ZMeZyqRmjUXxaDLQHxcPfHPTXA99AoXgVYtiNvPGdy6yXloRIrmVaAs1I0YLZuJ8+pBfRJM1LBHv8m9kJ+68VP/NHcdSsZxZb//4fJpBhpVDEfA7Wg9dCcj1Ds7Zv6XnMGBYTfy0VVMQr2TNNy1AS69aNVtqlnYfabxTA/CKNx/HLlBE30EbmgclGajk21wdol8ykxeiggQMZajnrKgoLJNIpK7aa4C6jUxwtcUfT/MGMlorEYeOzC01Z6WZxWxiODVCU1btdYVTmUkGYflsR0pl/2r4oANp9FCM0O2UgBxnvEKLUOgw6d2h1UQpSSioyup6M4zvKH31Q70Zh9lERKYfSnAeJfelHryPKbrtyxJ+1lSovrcn1ICZznYTXLSuLRD/Bu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(86362001)(478600001)(53546011)(6512007)(41300700001)(2906002)(6506007)(26005)(9686003)(6486002)(8676002)(66556008)(66476007)(82960400001)(110136005)(316002)(45080400002)(38100700002)(186003)(5660300002)(4326008)(8936002)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8GHQEWGDAmV9i5MmWLTdS3Eo/7LKtbkxS0WR38jZn7+MSy5h24sfM2dvyvSm?=
 =?us-ascii?Q?Pdvx3GlcSR9fQGkFUzwZzjojIF9dOJIYS0aCnWf/BKnxN/CmIN4mZmMYukQC?=
 =?us-ascii?Q?stE9oxUU4nnCdLu1vGgPYgtzx1Z+wLZQ7LrFln8xK6imyEPp4GbTPPKhp1Vh?=
 =?us-ascii?Q?pzis/oa8ffvycnzkwIGgniOE7mJSEMKCflCjvZljMH1oHoi+UEYZP9NcpEf5?=
 =?us-ascii?Q?b/4WG9xcVrdOmXMU0P4XLOiVlj2+AO7SJzNCQjAitzeKKjgreIbw7hOyrb8C?=
 =?us-ascii?Q?pyEhDYwarJuIgqMnYaJv5ePa44kNE0lyFsGaLuaDwR6WIBrFrJu1CRTfB0xe?=
 =?us-ascii?Q?Q7HIQzeVUqxt27uRDP0pICiu8UnrsfY9RKAA4IuzvTusjkR54PvCQVyjnIcV?=
 =?us-ascii?Q?rZq0v6GGDrGpJaz2CKcxZUNlxso+g0Sqrv28Ag/OlJ16XBpWB0Ox/74X1klT?=
 =?us-ascii?Q?wHNhNi6X7Nm9UeT0diaEfqiC4FqAr+k1HtHhRsdvcoCKPRsOxZTnAk7KrK7k?=
 =?us-ascii?Q?nRUBMDXqVxzJMfOGFbYCjp4KY130hcQrgjN9ALa8hSexxJvGr6VwUaEaHN20?=
 =?us-ascii?Q?PrEgCeibncY9ilerQEdq4doOHwMRznYUdKWUCG8GVDiuG6+Ne8bXu2styz5b?=
 =?us-ascii?Q?KlTH1Czy/JWLDN5h5+DOaI1W7Zu93Q9JDBi/L9YmhQaQem1IGSGIaAnV/7IT?=
 =?us-ascii?Q?ttGqoKuOSTZLH/q1uGSdesQCa/g1+IX6/EuuKACuxe5EpJ8P2PyqPlRtzU5m?=
 =?us-ascii?Q?sdFSns4kSBx4NVQp1JHfCbThc+Dym5MpymZLKBdbKtB5xVuCIixctxsWSuVp?=
 =?us-ascii?Q?+NxU/mYelJeyyRhZ5tfAJGWjRMNmjeFQLRJlNUIohHiaxYyQsri2+jYxzlLT?=
 =?us-ascii?Q?CkKMrHuQMr7KS5f/D9Z4ruyRT4r6sdkIs17bb5GVLaMSnhKCv/kBxeIyQbba?=
 =?us-ascii?Q?PilLVQSSV6Caalmxhyg0cvFkWzlwve5i5YeGx/taYTjqe8WWSSzCiEm+eVng?=
 =?us-ascii?Q?6PtSRp4yvjSnNJe9QGYe38D2nnUXcOmd0As+vy35a5pFOhX/7CeHwm1V5rV6?=
 =?us-ascii?Q?cFbqCcXwbKRee8fyEs8K/F8/YEvL6id91trGf7drIpnJvyyvvh6TFtMR4xWc?=
 =?us-ascii?Q?26cDH8y1iIDd+f31izSYQROKE7S4Jjl8pc3O5pqnUHM/fUc0hpyGd8LuFQv5?=
 =?us-ascii?Q?Mtq6qSNVlhsmc3/HDsWNeral86+SJWjcHvgGZQh1ZJ6LPm3PgdxFwGUL+6/y?=
 =?us-ascii?Q?ugip8bc2VCQhst8CTc/X3B3X+zbTf5J7Qv6fPNWZI0wDLSmqGoR1gCYT76vX?=
 =?us-ascii?Q?tOoyIZTyMrAGHvyFmlrZ+WhzM4enAMh6IwZ6w0aj6fwILxmfjDH56JsQO0e2?=
 =?us-ascii?Q?imcUemuzFb0TDzGR69i1yfkRalQGIuM9kX0H5G8mmr93iHir1i8uhiRugzuW?=
 =?us-ascii?Q?wvn9bQR8aMHZon90xJ5odwiULCmfa7WXR92AWabauhoYY35ty/jbMV2AiPhJ?=
 =?us-ascii?Q?IfkxcHpqGQQjYACYpF80hsqkdRWrtjkFRpYd9a4t6L+vQBdyDTUMhl+Dwffp?=
 =?us-ascii?Q?pJlafqpEwqOdgW4M3fkANaaxoYItb6n2cvc1bhtFO4LalAUcBwAy6zBd1ytR?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d108bd6-c9ea-4740-ba38-08da7f1138ef
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 22:55:17.4471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4o1PKjYIbKSYXNCmchsouUdzXZPT3gmcqBAmace08vloCYeFIrQFoc0RRit1C4X48k5+Q2DMm9VZDo3aPtiTj2jZ1vQ9Sz41auGIf3kyeI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2829
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 12 Aug 2022 16:44:03 +0100
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu, 11 Aug 2022 18:08:57 +0100
> > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > 
> > > On Tue, 9 Aug 2022 17:08:25 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > On Tue, 9 Aug 2022 21:07:06 +0800
> > > > Bobo WL <lmw.bobo@gmail.com> wrote:
> > > >     
> > > > > Hi Jonathan
> > > > > 
> > > > > Thanks for your reply!
> > > > > 
> > > > > On Mon, Aug 8, 2022 at 8:37 PM Jonathan Cameron
> > > > > <Jonathan.Cameron@huawei.com> wrote:      
> > > > > >
> > > > > > Probably not related to your problem, but there is a disconnect in QEMU /
> > > > > > kernel assumptionsaround the presence of an HDM decoder when a HB only
> > > > > > has a single root port. Spec allows it to be provided or not as an implementation choice.
> > > > > > Kernel assumes it isn't provide. Qemu assumes it is.
> > > > > >
> > > > > > The temporary solution is to throw in a second root port on the HB and not
> > > > > > connect anything to it.  Longer term I may special case this so that the particular
> > > > > > decoder defaults to pass through settings in QEMU if there is only one root port.
> > > > > >        
> > > > > 
> > > > > You are right! After adding an extra HB in qemu, I can create a x1
> > > > > region successfully.
> > > > > But have some errors in Nvdimm:
> > > > > 
> > > > > [   74.925838] Unknown online node for memory at 0x10000000000, assuming node 0
> > > > > [   74.925846] Unknown target node for memory at 0x10000000000, assuming node 0
> > > > > [   74.927470] nd_region region0: nmem0: is disabled, failing probe      
> > > > 
> > > > Ah. I've seen this one, but not chased it down yet.  Was on my todo list to chase
> > > > down. Once I reach this state I can verify the HDM Decode is correct which is what
> > > > I've been using to test (Which wasn't true until earlier this week). 
> > > > I'm currently testing via devmem, more for historical reasons than because it makes
> > > > that much sense anymore.      
> > > 
> > > *embarassed cough*.  We haven't fully hooked the LSA up in qemu yet.
> > > I'd forgotten that was still on the todo list. I don't think it will
> > > be particularly hard to do and will take a look in next few days.
> > > 
> > > Very very indirectly this error is causing a driver probe fail that means that
> > > we hit a code path that has a rather odd looking check on NDD_LABELING.
> > > Should not have gotten near that path though - hence the problem is actually
> > > when we call cxl_pmem_get_config_data() and it returns an error because
> > > we haven't fully connected up the command in QEMU.  
> > 
> > So a least one bug in QEMU. We were not supporting variable length payloads on mailbox
> > inputs (but were on outputs).  That hasn't mattered until we get to LSA writes.
> > We just need to relax condition on the supplied length.
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index c352a935c4..fdda9529fe 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -510,7 +510,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> >      cxl_cmd = &cxl_cmd_set[set][cmd];
> >      h = cxl_cmd->handler;
> >      if (h) {
> > -        if (len == cxl_cmd->in) {
> > +        if (len == cxl_cmd->in || !cxl_cmd->in) {
> Fix is wrong as we use ~0 as the placeholder for variable payload, not 0.
> 
> With that fixed we hit new fun paths - after some errors we get the
> worrying - not totally sure but looks like a failure on an error cleanup.
> I'll chase down the error source, but even then this is probably triggerable by
> hardware problem or similar.  Some bonus prints in here from me chasing
> error paths, but it's otherwise just cxl/next + the fix I posted earlier today.

One of the scenarios that I cannot rule out is nvdimm_probe() racing
nd_region_probe(), but given all the work it takes to create a region I
suspect all the nvdimm_probe() work to have completed...

It is at least one potentially wrong hypothesis that needs to be chased
down.

> 
> [   69.919877] nd_bus ndbus0: START: nd_region.probe(region0)
> [   69.920108] nd_region_probe
> [   69.920623] ------------[ cut here ]------------
> [   69.920675] refcount_t: addition on 0; use-after-free.
> [   69.921314] WARNING: CPU: 3 PID: 710 at lib/refcount.c:25 refcount_warn_saturate+0xa0/0x144
> [   69.926949] Modules linked in: cxl_pmem cxl_mem cxl_pci cxl_port cxl_acpi cxl_core
> [   69.928830] CPU: 3 PID: 710 Comm: kworker/u8:9 Not tainted 5.19.0-rc3+ #399
> [   69.930596] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> [   69.931482] Workqueue: events_unbound async_run_entry_fn
> [   69.932403] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [   69.934023] pc : refcount_warn_saturate+0xa0/0x144
> [   69.935161] lr : refcount_warn_saturate+0xa0/0x144
> [   69.936541] sp : ffff80000890b960
> [   69.937921] x29: ffff80000890b960 x28: 0000000000000000 x27: 0000000000000000
> [   69.940917] x26: ffffa54a90d5cb10 x25: ffffa54a90809e98 x24: 0000000000000000
> [   69.942537] x23: ffffa54a91a3d8d8 x22: ffff0000c5254800 x21: ffff0000c5254800
> [   69.944013] x20: ffff0000ce924180 x19: ffff0000c5254800 x18: ffffffffffffffff
> [   69.946100] x17: ffff5ab66e5ef000 x16: ffff80000801c000 x15: 0000000000000000
> [   69.947585] x14: 0000000000000001 x13: 0a2e656572662d72 x12: 657466612d657375
> [   69.948670] x11: 203b30206e6f206e x10: 6f69746964646120 x9 : ffffa54a8f63d288
> [   69.950679] x8 : 206e6f206e6f6974 x7 : 69646461203a745f x6 : 00000000fffff31e
> [   69.952113] x5 : ffff0000ff61ba08 x4 : 00000000fffff31e x3 : ffff5ab66e5ef000
> root@debian:/sys/bus/cxl/devices/decoder0.0/region0# [   69.954752] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0000c512e740
> [   69.957098] Call trace:
> [   69.957959]  refcount_warn_saturate+0xa0/0x144
> [   69.958773]  get_ndd+0x5c/0x80
> [   69.959294]  nd_region_register_namespaces+0xe4/0xe90
> [   69.960253]  nd_region_probe+0x100/0x290
> [   69.960796]  nvdimm_bus_probe+0xf4/0x1c0
> [   69.962087]  really_probe+0x19c/0x3f0
> [   69.962620]  __driver_probe_device+0x11c/0x190
> [   69.963258]  driver_probe_device+0x44/0xf4
> [   69.963773]  __device_attach_driver+0xa4/0x140
> [   69.964471]  bus_for_each_drv+0x84/0xe0
> [   69.965068]  __device_attach+0xb0/0x1f0
> [   69.966101]  device_initial_probe+0x20/0x30
> [   69.967142]  bus_probe_device+0xa4/0xb0
> [   69.968104]  device_add+0x3e8/0x910
> [   69.969111]  nd_async_device_register+0x24/0x74
> [   69.969928]  async_run_entry_fn+0x40/0x150
> [   69.970725]  process_one_work+0x1dc/0x450
> [   69.971796]  worker_thread+0x154/0x450
> [   69.972700]  kthread+0x118/0x120
> [   69.974141]  ret_from_fork+0x10/0x20
> [   69.975141] ---[ end trace 0000000000000000 ]---
> [   70.117887] Into nd_namespace_pmem_set_resource()
