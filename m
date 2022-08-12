Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B21C00140
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 16:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239066AbiHLQDb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 Aug 2022 12:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbiHLQDa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 Aug 2022 12:03:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EFB9F0FF
        for <linux-cxl@vger.kernel.org>; Fri, 12 Aug 2022 09:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660320209; x=1691856209;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2JSuNX2kMAn8hrIob+mJJqb3hgUOtISMKUFm40bOSQM=;
  b=WwK28wAuVRXn/5C1tm9/XJSIBQdXU20ESuZ/boixdkni5aY/zgxzl4PW
   80hbPcW+9Y4C6AJTnmRH9xA7mWdYvrqmPQCm8XwavnGsD8TBBQycvD6ET
   Y7NQALhcUoS/RahyuIHHv22W4b+QI3iezXrQVw+SER3S7E66VLdpnssuj
   uBM7jEO+gooU5tHxQXIHr1LyPBR2vDhM5A0riHcInoEseD2POeVwiEVCG
   6aKP3mfi829mwUOQqhn3j0ftFduQAKwqjtCrOrMDNbZmjoXXR0g/f/z4+
   /16RDUeDrkJEgfUdjeqYQe6zeoCKInv/0N8bdttc+x6hg/FPfCCA8yxl+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="353364558"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="353364558"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 09:03:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="674116427"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 12 Aug 2022 09:03:24 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 12 Aug 2022 09:03:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 12 Aug 2022 09:03:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 12 Aug 2022 09:03:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCVNMIAchugyDqp1TTVKlE1pffZJ7iQBwN1DZMadkVgAZeLUczVbztXag6tm7wym/xtwhJLDs9eKuKJvZY5zK8eMEqb3wHdHoQLJeTrQD59BuDtqOe/nMT2F234s50zAQeGXQuHH1/Ol1Q/IQ8EOiJnHyMyKS8L/Hg6wzdkJ+uyDAwvJdR9KQ9LU1irvtvqI2pyFrdbmFUyOvsWLtkZH7ENqlpZhrI4jmD7DJ1MOtaPzKn+6LYV5+1XsfaddUF4+GO5aURu3wpWbWYDibuUCcNyuKxJa0V17G/Ef1NDyYjRtwqSFjkKE2xKbMJD4wVVmifM48Oz/VPMiDSkloGUeNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhJ9qhn+pGNgKJxE0rCAAXl/1d+A4B7cBH6rmAYEIRY=;
 b=MdmuEPREubXxbNvJ2yj9xSAvqgX42Io3Qd/Wbb55A/N1pwNByG0TJVwjhTkMjBxfpmGJgluiyv5jQUVfF9Ky7+Bynv8x03Tj0NRqL12LWPN3L6uyNoCIYvbvezqOwjUsrdQyuHOhb9GEgkG3rEnuDGuveofMIfyETInsuIFFZ2ZAtK5eIicQBljzDYEUshzYkbdRZbcwffFtmzhEh8E1mfcQpG2xonyz8190g9WuXpHL06xWJA1rJ+Ad9Nx74C4VOEmLkcPPBY2m2OCpOdwbrC9Z/QTYrtschJIbsC3KEH1/qY3Sh0NNATOl2Bm/uM5bDehN1kTFA59fU2QasFiqBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by DM6PR11MB4724.namprd11.prod.outlook.com
 (2603:10b6:5:2ad::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 16:03:04 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 16:03:04 +0000
Date:   Fri, 12 Aug 2022 09:03:02 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bobo WL <lmw.bobo@gmail.com>, <linux-cxl@vger.kernel.org>,
        <qemu-arm@nongnu.org>
Subject: Re: [BUG] cxl can not create region
Message-ID: <62f679b67828f_992102942@dwillia2-xfh.jf.intel.com.notmuch>
References: <CAGr_yG0UrfJAMWta3EkR1F0JZ4j--sig74p6vKL3K6TZDx9YGA@mail.gmail.com>
 <20220808133727.00001171@huawei.com>
 <CAGr_yG36GSO8esyO9nn6OeOEN5zPSosEmBHbfYGwqNGiYOh9vw@mail.gmail.com>
 <20220809170825.00001b61@huawei.com>
 <20220811180857.00005e67@huawei.com>
 <20220812164403.00001654@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220812164403.00001654@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0013.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::18) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e274ebf-98a2-4fec-5263-08da7c7c23b4
X-MS-TrafficTypeDiagnostic: DM6PR11MB4724:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3t9BzmLiWGV+ASJn6QnZZcjMl8KwttFO47WnSNwpSba8Qq4EskJzuduCFs+uGTsia4igxL93DNX60CRejrtOxXqfYJQ9fJ7GjPBBgK1LUKnwBSVRmBNvWvAHJKuuKrCC0mFXez732zF7sKkTnh31sYZyX58rc3ZZTd8kPzb67T6caFd25j9qhfGWdgcPu2RQJvGVnzr4Bs/nRM5sRB09OByTny/nyGya5BF6c0yzByVM101c3Tm/V6UfFIaoA1ZHlPql7hf+94/KZRCia258L1w+77Ny5VWFbg6ji7yiV/g4mDgitEO5evNTafo9aFcbrMsynS4Orp1t+Y/K6PVj7A1XcInLFt6fKeSAqLFQBqEXQAmY9MdsGAQKqrU/hKvToGCAeJ+Law5zeXTJNSPBCmb1PRiD2yrj6MoCLwWhw4XOn4Tbz+SxYszAP/ItaBGYv28/2iWxpRPGnifJHEVoH6WpCiZZlcVNfYpGg4m3dFKyOPkAa3Kp6vOE1spR7oT1LthtM6GULtRZ9VhD9daMeWtmoeGSE9t7vjrN5W9zfgJE9JHruoYOyWPyw2MWABw19yav9t+Cgev/kaeUZgeE3jabb0zOuPjMqIg2QpFLr4UVzwTFM5lEiO4UX5ICZ+MULHxPyJFRZuYWy9oeco5TPOk6nJV3xkkT5n1bGb98o3b93L/gKb8QELOR4Iv9/TysFmII2GFqkS4/HGXKNjnHkG3DflUNs2fvctgyr6tQn34HN/9Zu35RP7k5TsthYWs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(376002)(39860400002)(346002)(366004)(478600001)(6486002)(6506007)(86362001)(186003)(41300700001)(6512007)(9686003)(53546011)(26005)(83380400001)(8676002)(66946007)(316002)(66556008)(4326008)(66476007)(54906003)(82960400001)(5660300002)(8936002)(38100700002)(2906002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W55eNMPZssnKFI/5yUlOgjrgwaAydaXzatplbXLM51WayHBSwoamEd2mwFYl?=
 =?us-ascii?Q?O6makACwzBseVMTmyzxjdZFKDZ+2l8XhUATOONKealG7WY1XibdBz4y1+9SL?=
 =?us-ascii?Q?3hNLy2CQITHWpQsK8we4sO6yT/tZrH/IiV9NjVuzJN9KkcpW4YyZOh5whhI1?=
 =?us-ascii?Q?wrpHjvNLeEW/6pZ0WB2wCg5W302QiejMiparmbakEYYXmh5mrtCcosTbND1D?=
 =?us-ascii?Q?zF0JS3ARzBQwnHCQ5SODEe74GOT5oXX9S98ZLZVbmhkT6Uy7LgjO31PzlI19?=
 =?us-ascii?Q?xwtpAfhxTUBhc/avSmOyrbSM8MVYD+236YH9Mh3mXt6kvZF+J8qG6QS8iNK+?=
 =?us-ascii?Q?U1lZ/SC3A9+QwGPeP3gFLlLMPXOOZ/b7Na4xUORhZu56vf91Gl24oyqr9jV4?=
 =?us-ascii?Q?eZFDJo7EYIXbRuMSEJsmX6Pzyd1wX4Ew/54UQtGnJtlXn7G0oi1NfQZOYngh?=
 =?us-ascii?Q?OyGcZ8DZ/VncK5fEilIKBCiZq6vMDRNujGv2j9KXrIZD+2hE4jGUndb526e8?=
 =?us-ascii?Q?73HAyrvdAbEwTD7CUs4myb3r3MahA5bcBSlnCGM7IOmI4ELZHfmyX6Sug9co?=
 =?us-ascii?Q?iqf6j8aFaAuk4G52JA9ksjQC344wroI5OGcHrtcZ35bH995btqrhvBbZF/Zp?=
 =?us-ascii?Q?3xeRQnOZd0zdD7WL8AKD3xeZb5m350QAtwRvd7Lb54sZBjy/JQCQtrVzl3h2?=
 =?us-ascii?Q?FZdtUj5MXukSdkW3kYOXzm5bWSEY6DiXL/iDtF/eSmssGnxO96hrNHOtUYmv?=
 =?us-ascii?Q?tLIi+DY/x3SvsbFUYDy1PY+T99nj7yM9GwxiY6SoonZ2aVUw3UL1wOe2K5La?=
 =?us-ascii?Q?wU+DjlZ+mBknfU6TPOKe0lcuHXPPiJFn6hADdEAULyc7elcLCUGaUJnxy3zE?=
 =?us-ascii?Q?UoJJ8BbRYxz08BNyu/Wb+tajIGHWgDqzSXlKUG2pqZGhK/TF+Dsopa9rU1Y4?=
 =?us-ascii?Q?W5h0M7I7XGuQ1slG3Kv0WF3EAunbNvncelY+3Oi6LXi/qFfVCGlxitOvS+Yh?=
 =?us-ascii?Q?xtvKAt/eEJd5fIvl1ZpXj8qPhhGMOo0Fzvl1ZaAObsl4GEYI8hov+aLEy0VL?=
 =?us-ascii?Q?hG8peLflr6H37Y8tzzHBzsjyJbKxIAQhdteJLk+6sduVgZN7RsVSoSldOumh?=
 =?us-ascii?Q?lGQTOv08r6n1b6KcZ51sbU5Q+3A2nO/D/xe4109ZAeKavQrnI1GzsvH1ZCI2?=
 =?us-ascii?Q?UAHhORLMSJR+q6u7r5cPyvfakbdLd5MiAF5mN8UVbAYD6cjNu0MHx8VeCDfx?=
 =?us-ascii?Q?R08TOgfmFA6J9EQ0ZugqC6yptoPInTzCwB+B1Tu9VDSk44tCxDr8QVzZYBic?=
 =?us-ascii?Q?2+NFmCRVe/vxB8LxDqr8zc9ZmOEu/XKfcsZtMTXSwbigEqIiWiVXROqt+Q1M?=
 =?us-ascii?Q?avDWYbZwhw3Z/rnaX01WlPNr4SOlPx5tdSg9Ve/WUhu90WtV2fQS9aqDtppo?=
 =?us-ascii?Q?k1nr5lTnrE9LfGHGnC5/Zczw8GlnwKauxl8sKw3bIZ71yQ6yv4jufLAMS/Xy?=
 =?us-ascii?Q?g0w6ugZ4krk6SiZagkr7IJ+WdFZ9QX7KfOpfA4090GkG13W3Lt1EhDT+lE+D?=
 =?us-ascii?Q?FChvJ4LRckJhOZjgh4olwTqfrpe8xwuSmLbAPWWzBkFvkAp5C2mhjgJdnkTi?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e274ebf-98a2-4fec-5263-08da7c7c23b4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 16:03:04.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+KGP8vqnbEK/F9G6KYvvUN67I/AdYZKPzkFdrQ0XYbBuymq3mS5lJ7TEZx3whc9Vsc8USvu0AlBzBsJwl4bFbxn1jmuB1J+0xjUUlpyh6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4724
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 11 Aug 2022 18:08:57 +0100
> Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> 
> > On Tue, 9 Aug 2022 17:08:25 +0100
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > On Tue, 9 Aug 2022 21:07:06 +0800
> > > Bobo WL <lmw.bobo@gmail.com> wrote:
> > >   
> > > > Hi Jonathan
> > > > 
> > > > Thanks for your reply!
> > > > 
> > > > On Mon, Aug 8, 2022 at 8:37 PM Jonathan Cameron
> > > > <Jonathan.Cameron@huawei.com> wrote:    
> > > > >
> > > > > Probably not related to your problem, but there is a disconnect in QEMU /
> > > > > kernel assumptionsaround the presence of an HDM decoder when a HB only
> > > > > has a single root port. Spec allows it to be provided or not as an implementation choice.
> > > > > Kernel assumes it isn't provide. Qemu assumes it is.
> > > > >
> > > > > The temporary solution is to throw in a second root port on the HB and not
> > > > > connect anything to it.  Longer term I may special case this so that the particular
> > > > > decoder defaults to pass through settings in QEMU if there is only one root port.
> > > > >      
> > > > 
> > > > You are right! After adding an extra HB in qemu, I can create a x1
> > > > region successfully.
> > > > But have some errors in Nvdimm:
> > > > 
> > > > [   74.925838] Unknown online node for memory at 0x10000000000, assuming node 0
> > > > [   74.925846] Unknown target node for memory at 0x10000000000, assuming node 0
> > > > [   74.927470] nd_region region0: nmem0: is disabled, failing probe    
> > > 
> > > Ah. I've seen this one, but not chased it down yet.  Was on my todo list to chase
> > > down. Once I reach this state I can verify the HDM Decode is correct which is what
> > > I've been using to test (Which wasn't true until earlier this week). 
> > > I'm currently testing via devmem, more for historical reasons than because it makes
> > > that much sense anymore.    
> > 
> > *embarassed cough*.  We haven't fully hooked the LSA up in qemu yet.
> > I'd forgotten that was still on the todo list. I don't think it will
> > be particularly hard to do and will take a look in next few days.
> > 
> > Very very indirectly this error is causing a driver probe fail that means that
> > we hit a code path that has a rather odd looking check on NDD_LABELING.
> > Should not have gotten near that path though - hence the problem is actually
> > when we call cxl_pmem_get_config_data() and it returns an error because
> > we haven't fully connected up the command in QEMU.
> 
> So a least one bug in QEMU. We were not supporting variable length payloads on mailbox
> inputs (but were on outputs).  That hasn't mattered until we get to LSA writes.
> We just need to relax condition on the supplied length.
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c352a935c4..fdda9529fe 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -510,7 +510,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      cxl_cmd = &cxl_cmd_set[set][cmd];
>      h = cxl_cmd->handler;
>      if (h) {
> -        if (len == cxl_cmd->in) {
> +        if (len == cxl_cmd->in || !cxl_cmd->in) {
>              cxl_cmd->payload = cxl_dstate->mbox_reg_state +
>                  A_CXL_DEV_CMD_PAYLOAD;
>              ret = (*h)(cxl_cmd, cxl_dstate, &len);
> 
> 
> This lets the nvdimm/region probe fine, but I'm getting some issues with
> namespace capacity so I'll look at what is causing that next.
> Unfortunately I'm not that familiar with the driver/nvdimm side of things
> so it's take a while to figure out what kicks off what!

The whirlwind tour is that 'struct nd_region' instances that represent a
persitent memory address range are composed of one more mappings of
'struct nvdimm' objects. The nvdimm object is driven by the dimm driver
in drivers/nvdimm/dimm.c. That driver is mainly charged with unlocking
the dimm (if locked) and interrogating the label area to look for
namespace labels.

The label command calls are routed to the '->ndctl()' callback that was
registered when the CXL nvdimm_bus_descriptor was created. That callback
handles both 'bus' scope calls, currently none for CXL, and per nvdimm
calls. cxl_pmem_nvdimm_ctl() translates those generic LIBNVDIMM commands
to CXL commands.

The 'struct nvdimm' objects that the CXL side registers have the
NDD_LABELING flag set which means that namespaces need to be explicitly
created / provisioned from region capacity. Otherwise, if
drivers/nvdimm/dimm.c does not find a namespace-label-index block then
the region reverts to label-less mode and a default namespace equal to
the size of the region is instantiated.

If you are seeing small mismatches in namespace capacity then it may
just be the fact that by default 'ndctl create-namespace' results in an
'fsdax' mode namespace which just means that it is a block device where
1.5% of the capacity is reserved for 'struct page' metadata. You should
be able to see namespace capacity == region capacity by doing "ndctl
create-namespace -m raw", and disable DAX operation.

Hope that helps.
