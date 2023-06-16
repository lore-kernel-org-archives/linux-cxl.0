Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78734EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 04:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjFPELh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 00:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFPELf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 00:11:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9E72947
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 21:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686888692; x=1718424692;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jbpy2ay72vUKuZItZ+iyTVZ0pn732NxW8MQLPi0X1ag=;
  b=URQESbp5FjJlAaSJjXm40lziyt+YYwVcmp2fMuQxaU1MMgueNMrk1t0J
   Y3qxsczT6TC10p4vxxBxWPdcpbZ7/6tHnDsVGxjqTSzpSLkQu3lynoHLS
   aPYZwAE2q4VEGGQWkuu+6g+8Fo1nfxw604dgIhfxtoagafb6DR30AFBcY
   xPcbbsBpk2WhPbVYu/+6joFsR4dRLp3KBg+X34w6mESvf21/HGBbucAPx
   1V7/8DIPtyUjTdbrM7shK1zmRdqmylhtXITXOUufCnish4VZOTw80fzcS
   luD/1UVmMP41AfFLChiUyKsFA9qWPLKHDHas7KNGM0IukS3CKJXQDc00P
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="445493001"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="445493001"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 21:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="782742647"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="782742647"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2023 21:11:31 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 21:11:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 21:11:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 21:11:30 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 21:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Md20PwWxR5JSkHdSrrGTiqbav5X/MwB/s94Bug7ACe/foL4FQLXZJpS8vekU6Ncx3YzRxrA5BxWRGLkooNiR3QUmBgTJzs6Sef3rnybovMNPvv6NXENP0uc+eulDqz+xpYOL3Uji6ag63iB2PTOqPF22de6FKZ1pKj7eCPLa8IEvt55iLo7IgZeifIWeSS3PckJpUcmftJLZxtpbbWRDtsGNVBXKMj4TlWnj4/2zqgEbkJFyOPWekZ3LCr6V1MHOyn3tV67AF0YOsypPuLAiWBVK7DtGG/Z5XrshWfr1zz9+Pdh710k9mPNeE7xz85JSOEohIFB61+pOVv6QT8AIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+FEuBn+L9MnTHzI2VTF/2lhsZiFo9cTCoXwfhos58dk=;
 b=fGvrd10o/+wep7sk4l6bprhzUW2vGjJLr+cKp6mgVlDmJ5/K5mD2BXmtiE/ePIflZMULBbeLvJ/YfzrYPzTRM/EoDXvJAnfKrqNPf5gqmcZP0kAGp++eyMjxdD/hvW1T14pc5nGNyPWUsOjJDrxoXAvgufMwTD/OfcQMyKOteQb6crBMN4VHWDK1lqr7qBVvdctNa11APRqlukEEl+yJrDQPueta4xFyh+ZgdffyEvTxO2vB5PP1cp2SeqsgkEPK1AVW7U+LIr0AyF1I+1GAx4wJpaMhQLTSVVcsVAVYDU0AKDQAWNafbC9XTdAD596/k3m/k7tokUmGDSZBK7sY8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA1PR11MB6244.namprd11.prod.outlook.com (2603:10b6:208:3e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 04:11:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 04:11:25 +0000
Date:   Thu, 15 Jun 2023 21:11:17 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Message-ID: <648be0e5de7a9_1c7ab429469@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
 <ZIp1TSeHUElgSunG@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIp1TSeHUElgSunG@aschofie-mobl2>
X-ClientProxiedBy: BYAPR21CA0023.namprd21.prod.outlook.com
 (2603:10b6:a03:114::33) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA1PR11MB6244:EE_
X-MS-Office365-Filtering-Correlation-Id: 234fc291-8fbe-40e2-8dc1-08db6e1fbf77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fsSwcVlHXwP3LtG7cZQe9XFoh1GFUQAAnelZ97ey4K9n9HETQ0qwVS6NejDVbI3KmMaBeI/MrAhU+9ALMYusa9yxcQZoxcVYDoTLdBX2syFad06WlMaD88thxCJp8ngpnSc75SgUB2XhCe1Pdm9AA1KXDkeOqW4za+HWHg62asVxfzG2SO7ctxPhoD5lB4kpTl+xWAJT3n1dQNMqelgm0PBOxUeuRFA7YjX6FFn13TLqkA5eOZGH1ym40AjBC9FHdwXUOeligjjrHMBNd2DClWClpGwK0pa84Ll+cacY9Te7XxPgbDQyBZPJu1jlo3mB832wgkjxn4eEJELwMsvvldttpr9UriMSfqI4txtlRyaghae0PsQ+8NFKNgfgTUxR0BgPYymjrwMnU5No4QQ9CGUfySqejMFQFtldtQqug+7AAOH05Rao3V9qvoklOncN/4tH3kFEF0zbE/rzuu5BEOvhzce03ALlSHwqDDHKxMVDDqNyc5Zn5dtT8wd5PX4kaW1Rc2kEywEF8C5KwLQUZ/XSJPU4PTouHXDn4rewnRPfNc6p5esgn/FKWtEBlwQc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(54906003)(41300700001)(8676002)(86362001)(66946007)(66556008)(66476007)(6486002)(8936002)(316002)(6666004)(4326008)(9686003)(478600001)(26005)(6512007)(44832011)(30864003)(5660300002)(83380400001)(6506007)(2906002)(186003)(82960400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8n3CObHKw8WdwP+Sq7WMIfrlz5b8c8+deD5cmALZbIggiBVQ4BX4Z6NRtsly?=
 =?us-ascii?Q?hG4+9gzKl3raG8rzSf2YNJcqGqijRntYAOEYsJaWj5TyVHWUyr57YmxlX6RY?=
 =?us-ascii?Q?Yg1uvvLywVGeq761bxwV0XAhPYB1u/1Xz8/PlHsdZu1OeffNHn0pQYadUJqF?=
 =?us-ascii?Q?SAiDR84cx/FiPxXhJhFDpcm0DKl0SzFfr/TD6dnZX3xTLxtQRZYVr7kzzCRa?=
 =?us-ascii?Q?h4Q2hzz9xmrGRW4mGHBOdgV+gxn2jqbvCNTeBfRuQ3KCcV+jOiaF4zFMBGSO?=
 =?us-ascii?Q?64HSJLg6VFsTvg3KN81fPi73ILebQ9rImgSovvv5rCyODU0onVqe+1odFLxY?=
 =?us-ascii?Q?vVXEkYAEfMEyFQnSVptuAVvOVGj6LMsz6rk38NBKM1NQKRoMw3AWpQk13mmc?=
 =?us-ascii?Q?WXTkcjez3ul3HXVHKI14O90UhlUzwCG3Iwjnyl8VzGjPlbNfgcV1nf2CHboy?=
 =?us-ascii?Q?VnDMk0vfSTGPbdkk6cxWjMkAxTNKhKvjFc5pMUVInucryN8ME08teeeGLHPR?=
 =?us-ascii?Q?LsdV6oKWJYfoIXwrBZZj+M/tBlnyFm1ltdwaJ4rzGuj/jEI74lAaqlS0kmtm?=
 =?us-ascii?Q?7un3xnvbN1SbruMbiQR1ufbvgJBvBP/5HpCHfqqzl+23Vucb2zV/tJybqg/V?=
 =?us-ascii?Q?sSDQQwgcdAlcGnVWgcXtQUF3K+J4xyXlUkaQ20ZxngdqBL2nx5J5RmVRx4NV?=
 =?us-ascii?Q?NO6/LBemEvtDl50n0lXUrq17bRUkmc4vqGTWqsNlRB/PtKfnzUZczdRuVusr?=
 =?us-ascii?Q?WnvO4Kxsepx7oW/DLmDaxevUxSkkJBCSISW6TzImLwISvedHHKRGOI85RLTX?=
 =?us-ascii?Q?DiiwhZAXLkAoQM3Nu5StU3jmLDgHggOy/OTV76M95ljuUIcWzKgz5xRSc/oa?=
 =?us-ascii?Q?8ROUAxfaEGs1HTPP01ugXH1rC2NI9pqF1eFGlcOxB1kxS5mWO5kmr9c4+sN+?=
 =?us-ascii?Q?fKROqaCIFM/rEsgLMCSbJsLpngIwRQr6HbmOZEcKSVctpUgRbWqYjhYq9j1b?=
 =?us-ascii?Q?IVHonlyqhr6z1el1G+XicE9kn4Kfd4z8SLOrVEqjrz6Nc3aCvsRI8rIcreQU?=
 =?us-ascii?Q?wsxfVD5q/aatbcLjgDk+ybrsDIamfzbAoS0j0Ct+NXif+SCuLhr3Uw7iYJhx?=
 =?us-ascii?Q?u/tLmzYNsOZlTEGHnIVNjrrt1OLb0R2uIprwEt2YvTyhPxFZ4XiUwkGanZpm?=
 =?us-ascii?Q?HKRn9VPW9RmZDV2GMsIxim4zjlprkrDAKkjNerkM/L1Z7PO1HeW9o3sO+MtY?=
 =?us-ascii?Q?epBhUUQTMmFtmRmLrrfVuSdFgLnTdKuQp3e7f0K7ccc8DsU6sHigKGblEe/G?=
 =?us-ascii?Q?RZerpX5GSXDsNCDGM2LLX2M9zbxpJVB6ylZyanEuAwSPrlZJ5yuj6dSjh4Vo?=
 =?us-ascii?Q?GnJllz8Y6K4vvPt+UeUHtEY7jE41HKWR9TsEXNnE+9HtIbZ4IRRhNG8PWTuu?=
 =?us-ascii?Q?YLipup9M+oBi1fe0MQE6xi/++9Pv5HIDsgSpb+nOrxGgS7jQLDOBesi0S3Kj?=
 =?us-ascii?Q?/Yw3xKtxDuDMFXKWSw/6t8ShLw1Rmz3xGPSUfXeupm8RAglNvianrvRPqffN?=
 =?us-ascii?Q?dnVRL97cMcBA/v25RwVld27riiNIJw1V0sxCWdbJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 234fc291-8fbe-40e2-8dc1-08db6e1fbf77
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 04:11:24.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HtpJE8R5O3oJG8ZRS99NY5RxJEvNHANcGfInGNsOhul/eEQEFHjeY3f6D8TK6TWP2xTPOjjdVtoG14YSWOuS+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6244
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Wed, Jun 14, 2023 at 12:16:31PM -0700, Ira Weiny wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > A dynamic capacity device utilizes events to signal the host about the
> > changes to the allocation of DC blocks. The device communicates the
> > state of these blocks of dynamic capacity through an extent list that
> > describes the starting DPA and length of all blocks the host can access.
> > 
> > Based on the dynamic capacity add or release event type,
> > dynamic memory represented by the extents are either added
> > or removed as devdax device.
> 
> Nice commit msg, please align second paragraph w first.

ok... fixed.  :-)

> 
> > 
> > Process the dynamic capacity add and release events.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 
> > ---
> > [iweiny: Remove invalid comment]
> > ---
> >  drivers/cxl/core/mbox.c   | 345 +++++++++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/core/region.c | 214 +++++++++++++++++++++++++++-
> >  drivers/cxl/core/trace.h  |   3 +-
> >  drivers/cxl/cxl.h         |   4 +-
> >  drivers/cxl/cxlmem.h      |  76 ++++++++++
> >  drivers/cxl/pci.c         |  10 +-
> >  drivers/dax/bus.c         |  11 +-
> >  drivers/dax/bus.h         |   5 +-
> >  8 files changed, 652 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index c5b696737c87..db9295216de5 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -767,6 +767,14 @@ static const uuid_t log_uuid[] = {
> >  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
> >  };
> >  
> > +/* See CXL 3.0 8.2.9.2.1.5 */
> > +enum dc_event {
> > +	ADD_CAPACITY,
> > +	RELEASE_CAPACITY,
> > +	FORCED_CAPACITY_RELEASE,
> > +	REGION_CONFIGURATION_UPDATED,
> > +};
> > +
> >  /**
> >   * cxl_enumerate_cmds() - Enumerate commands for a device.
> >   * @mds: The driver data for the operation
> > @@ -852,6 +860,14 @@ static const uuid_t mem_mod_event_uuid =
> >  	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
> >  		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
> >  
> > +/*
> > + * Dynamic Capacity Event Record
> > + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> > + */
> > +static const uuid_t dc_event_uuid =
> > +	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c,
> > +		0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a);
> > +
> >  static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
> >  				   enum cxl_event_log_type type,
> >  				   struct cxl_event_record_raw *record)
> > @@ -945,6 +961,188 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
> >  	return rc;
> >  }
> >  
> > +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> > +				struct cxl_mbox_dc_response *res,
> > +				int extent_cnt, int opcode)
> > +{
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int rc, size;
> > +
> > +	size = struct_size(res, extent_list, extent_cnt);
> > +	res->extent_list_size = cpu_to_le32(extent_cnt);
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = opcode,
> > +		.size_in = size,
> > +		.payload_in = res,
> > +	};
> > +
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +
> > +	return rc;
> > +
> > +}
> > +
> > +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> > +					int *n, struct range *extent)
> > +{
> > +	struct cxl_mbox_dc_response *dc_res;
> > +	unsigned int size;
> > +
> > +	if (!extent)
> > +		size = struct_size(dc_res, extent_list, 0);
> > +	else
> > +		size = struct_size(dc_res, extent_list, *n + 1);
> > +
> > +	dc_res = krealloc(*res, size, GFP_KERNEL);
> > +	if (!dc_res)
> > +		return -ENOMEM;
> > +
> > +	if (extent) {
> > +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> > +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> > +		dc_res->extent_list[*n].length = 
> > +				cpu_to_le64(range_len(extent));
> 
> Unnecessary return. I think that fits in 80 columns.

exactly 80...  fixed.

> 
> > +		(*n)++;
> > +	}
> > +
> > +	*res = dc_res;
> > +	return 0;
> > +}
> > +/**
> > + * cxl_handle_dcd_event_records() - Read DCD event records.
> > + * @mds: The memory device state
> > + *
> > + * Returns 0 if enumerate completed successfully.
> > + *
> > + * CXL devices can generate DCD events to add or remove extents in the list.
> > + */
> 
> That's a kernel doc comment, so maybe can be clearer.

Or remove the kernel doc comment.

> It's called 'handle', so 'Read DCD event records' seems like a mismatch.

Yea.

> Probably needs more explaining.

Rather I would say less.  How about simply:

/* Returns 0 if the event was handled successfully. */

Or even nothing at all.  It is a static function and used 1 place.  Not
sure we even need that line.

> 
> 
> > +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> > +					struct cxl_event_record_raw *rec)
> > +{
> > +	struct cxl_mbox_dc_response *dc_res = NULL;
> > +	struct device *dev = mds->cxlds.dev;
> > +	uuid_t *id = &rec->hdr.id;
> > +	struct dcd_event_dyn_cap *record =
> > +			(struct dcd_event_dyn_cap *)rec;
> > +	int extent_cnt = 0, rc = 0;
> > +	struct cxl_dc_extent_data *extent;
> > +	struct range alloc_range, rel_range;
> > +	resource_size_t dpa, size;
> > +
> 
> Please reverse x-tree. And if things like that *record can't fit within
> 80 columns and in reverse x-tree order, then assign it afterwards.

Done.

> 
> 
> > +	if (!uuid_equal(id, &dc_event_uuid))
> > +		return -EINVAL;
> > +
> > +	switch (record->data.event_type) {
> 
> Maybe a local for record->data.extent that is used repeatedly below,
> or,
> Perhaps pull the length and dpa local defines you made down in the
> RELEASE_CAPACITY up here and share them with ADD_CAPACITY. That'll
> reduce the le65_to_cpu noise. Add similar for shared_extn_seq.

I'm thinking ADD_CAPACITY and RELEASE_CAPACITY need to be 2 separate
functions which make this function a simple uuid check and event_type
switch.

Having local variables for those become much cleaner then.

I think the handling of dc_res would be cleaner then too.

> 
> 
> > +	case ADD_CAPACITY:
> > +		extent = devm_kzalloc(dev, sizeof(*extent), GFP_ATOMIC);
> > +		if (!extent)
> > +			return -ENOMEM;
> > +
> > +		extent->dpa_start = le64_to_cpu(record->data.extent.start_dpa);
> > +		extent->length = le64_to_cpu(record->data.extent.length);
> > +		memcpy(extent->tag, record->data.extent.tag,
> > +				sizeof(record->data.extent.tag));
> > +		extent->shared_extent_seq =
> > +			le16_to_cpu(record->data.extent.shared_extn_seq);
> > +		dev_dbg(dev, "Add DC extent DPA:0x%llx LEN:%llx\n",
> > +					extent->dpa_start, extent->length);
> > +		alloc_range = (struct range) {
> > +			.start = extent->dpa_start,
> > +			.end = extent->dpa_start + extent->length - 1,
> > +		};
> > +
> > +		rc = cxl_add_dc_extent(mds, &alloc_range);
> > +		if (rc < 0) {
> 
> How about 
> 		if (rc >=)
> 			goto insert;
> 
> Then you can remove this level of indent.

I think if this is a separate function it will be better...

Also this entire indent block could be another sub function because AFAICS
(see below) it always returns out from this block (only via the 'out'
label in 1 case which seems redundant).

> 
> > +			dev_dbg(dev, "unconsumed DC extent DPA:0x%llx LEN:%llx\n",
> > +					extent->dpa_start, extent->length);
> > +			rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, NULL);
> > +			if (rc < 0) {
> > +				dev_err(dev, "Couldn't create extent list %d\n",
> > +									rc);
> > +				devm_kfree(dev, extent);
> > +				return rc;
> > +			}
> > +
> > +			rc = cxl_send_dc_cap_response(mds, dc_res,
> > +					extent_cnt, CXL_MBOX_OP_ADD_DC_RESPONSE);
> > +			if (rc < 0) {
> > +				devm_kfree(dev, extent);
> > +				goto out;

This if is not doing anything useful.  Because this statement ...

> > +			}
> > +
> > +			kfree(dc_res);
> > +			devm_kfree(dev, extent);

...  and the 'else' here end up being the same logic.  The 'out' label
flows through kfree(dc_res).  Is the intent that
cxl_send_dc_cap_response() has no failure consequences?

> > +
> > +			return 0;
> > +		}
> 
> insert:
> 
> > +
> > +		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
> > +				GFP_KERNEL);
> > +		if (rc < 0)
> > +			goto out;
> > +
> > +		mds->num_dc_extents++;
> > +		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &alloc_range);
> > +		if (rc < 0) {
> > +			dev_err(dev, "Couldn't create extent list %d\n", rc);
> > +			return rc;
> > +		}
> > +
> > +		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> > +					      CXL_MBOX_OP_ADD_DC_RESPONSE);
> > +		if (rc < 0)
> > +			goto out;
> > +
> > +		break;
> > +
> > +	case RELEASE_CAPACITY:
> > +		dpa = le64_to_cpu(record->data.extent.start_dpa);
> > +		size = le64_to_cpu(record->data.extent.length);
> 
> ^^ do these sooner and share

I think add/release should be their own functions.

> 
> > +		dev_dbg(dev, "Release DC extents DPA:0x%llx LEN:%llx\n",
> > +				dpa, size);
> > +		extent = xa_load(&mds->dc_extent_list, dpa);
> > +		if (!extent) {
> > +			dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
> > +			return -EINVAL;
> > +		}
> > +
> > +		rel_range = (struct range) {
> > +			.start = dpa,
> > +			.end = dpa + size - 1,
> > +		};
> > +
> > +		rc = cxl_release_dc_extent(mds, &rel_range);
> > +		if (rc < 0) {
> > +			dev_dbg(dev, "withhold DC extent DPA:0x%llx LEN:%llx\n",
> > +									dpa, size);
> > +			return 0;
> > +		}
> > +
> > +		xa_erase(&mds->dc_extent_list, dpa);
> > +		devm_kfree(dev, extent);
> > +		mds->num_dc_extents--;
> > +		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &rel_range);
> > +		if (rc < 0) {
> > +			dev_err(dev, "Couldn't create extent list %d\n", rc);
> > +			return rc;
> > +		}
> > +
> > +		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> > +					      CXL_MBOX_OP_RELEASE_DC);
> > +		if (rc < 0)
> > +			goto out;
> > +
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +out:
> 
> The out seems needless. Replace all 'goto out''s  with 'break'
> 
> I'm also a bit concerned about all the direct returns above.
> Can this be the single exit point?

I think so...

> kfree of a NULL ptr is OK.
> Maybe a bit more logic here to do that devm_free is all that
> is needed.

... but even more clean up so that the logic is:

handle_event()
{

	... do checks ...

	switch (type):
	case ADD...:
		rc = handle_add();
		break;
	case RELEASE...:
		rc = handle_release();
		break;
	default:
		rc = -EINVAL;
		break;
	}

	return rc;
}

> 
> 
> > +	kfree(dc_res);
> > +	return rc;
> > +}
> > +
> >  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  				    enum cxl_event_log_type type)
> >  {
> > @@ -982,9 +1180,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
> >  		if (!nr_rec)
> >  			break;
> >  
> > -		for (i = 0; i < nr_rec; i++)
> > +		for (i = 0; i < nr_rec; i++) {
> >  			cxl_event_trace_record(cxlmd, type,
> >  					       &payload->records[i]);
> > +			if (type == CXL_EVENT_TYPE_DCD) {
> > +				rc = cxl_handle_dcd_event_records(mds,
> > +						&payload->records[i]);
> > +				if (rc)
> > +					dev_err_ratelimited(dev,
> > +						"dcd event failed: %d\n", rc);
> > +			}
> 
> 
> Reduce indent option:
> 
> 			if (type != CXL_EVENT_TYPE_DCD)
> 				continue;
> 
> 			rc = cxl_handle_dcd_event_records(mds,
> 							  &payload->records[i]);			if (rc)
> 				dev_err_ratelimited(dev,
> 						    "dcd event failed: %d\n", rc);

Ah...  Ok.

Honestly I just made this change and I'm not keen on it.  I think it makes
the detail that the event was DCD obscured.

I'm also questioning the need to the error reporting here.  There seems to
be error messages in the critical parts of cxl_handle_dcd_event_records()
which would give a clue as to why the DCD failed.  (Other than some common
memory allocation issues.)  But also those errors are not rate limited.
So if we are concerned with a FM or other external entity causing events
which flood the logs it seems they all need to be debug or ratelimited.

> 
> I don't know where 'cxl_handle_dcd_event_records() was introduce,
> but I'm wondering now if it can have a short name.

Its the function above which needs all the rework.

> 
> > +		}
> >  
> >  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> >  			trace_cxl_overflow(cxlmd, type, payload);
> > @@ -1024,6 +1230,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
> >  		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
> >  	if (status & CXLDEV_EVENT_STATUS_INFO)
> >  		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> > +	if (status & CXLDEV_EVENT_STATUS_DCD)
> > +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
> >  
> > @@ -1244,6 +1452,140 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> >  
> > +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> > +			      unsigned int *extent_gen_num)
> > +{
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_dc_extents *dc_extents;
> > +	struct cxl_mbox_get_dc_extent get_dc_extent;
> > +	unsigned int total_extent_cnt;
> 
> Seems 'count' would probably suffice here.

Done.

> 
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	int rc;
> 
> Above - reverse x-tree please.

Done.

> 
> > +
> > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > +		return 0;
> > +	}
> > +
> > +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> > +	if (!dc_extents)
> > +		return -ENOMEM;
> > +
> > +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > +		.extent_cnt = 0,
> > +		.start_extent_index = 0,
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +		.payload_in = &get_dc_extent,
> > +		.size_in = sizeof(get_dc_extent),
> > +		.size_out = mds->payload_size,
> > +		.payload_out = dc_extents,
> > +		.min_out = 1,
> > +	};
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		goto out;
> > +
> > +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > +	*extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > +	dev_dbg(dev, "Total extent count :%d Extent list Generation Num: %d\n",
> > +			total_extent_cnt, *extent_gen_num);
> > +out:
> > +
> > +	kvfree(dc_extents);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return total_extent_cnt;
> > +
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);
> > +
> > +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> > +			   unsigned int index, unsigned int cnt)
> > +{
> > +	/* See CXL 3.0 Table 125 dynamic capacity config  Output Payload */
> > +	struct device *dev = mds->cxlds.dev;
> > +	struct cxl_mbox_dc_extents *dc_extents;
> > +	struct cxl_mbox_get_dc_extent get_dc_extent;
> > +	unsigned int extent_gen_num, available_extents, total_extent_cnt;
> > +	int rc;
> > +	struct cxl_dc_extent_data *extent;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	struct range alloc_range;
> > +
> 
> Reverse x-tree please.

Done.

> 
> > +	/* Check GET_DC_EXTENT_LIST is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> > +		return 0;
> > +	}
> 
> Can we even get this far if this cmd is not supported by the device?
> Is there a sooner place to test those bits?  Is this sysfs request?
> (sorry not completely following here).
> 

I'll have to check.  Perhaps Navneet knows.

> > +
> > +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> > +	if (!dc_extents)
> > +		return -ENOMEM;
> > +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> > +		.extent_cnt = cnt,
> > +		.start_extent_index = index,
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> > +		.payload_in = &get_dc_extent,
> > +		.size_in = sizeof(get_dc_extent),
> > +		.size_out = mds->payload_size,
> > +		.payload_out = dc_extents,
> > +		.min_out = 1,
> > +	};
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		goto out;
> > +
> > +	available_extents = le32_to_cpu(dc_extents->ret_extent_cnt);
> > +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> > +	extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> > +	dev_dbg(dev, "No Total extent count :%d Extent list Generation Num:%d\n",
> > +			total_extent_cnt, extent_gen_num);
> > +
> > +
> > +	for (int i = 0; i < available_extents ; i++) {
> > +		extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
> > +		if (!extent) {
> > +			rc = -ENOMEM;
> > +			goto out;
> > +		}
> > +		extent->dpa_start = le64_to_cpu(dc_extents->extent[i].start_dpa);
> > +		extent->length = le64_to_cpu(dc_extents->extent[i].length);
> > +		memcpy(extent->tag, dc_extents->extent[i].tag,
> > +					sizeof(dc_extents->extent[i].tag));
> > +		extent->shared_extent_seq =
> > +				le16_to_cpu(dc_extents->extent[i].shared_extn_seq);
> > +		dev_dbg(dev, "dynamic capacity extent[%d] DPA:0x%llx LEN:%llx\n",
> > +				i, extent->dpa_start, extent->length);
> > +
> > +		alloc_range = (struct range){
> > +			.start = extent->dpa_start,
> > +			.end = extent->dpa_start + extent->length - 1,
> > +		};
> > +
> > +		rc = cxl_add_dc_extent(mds, &alloc_range);
> > +		if (rc < 0)
> > +			goto out;
> > +		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
> > +				GFP_KERNEL);
> > +	}
> > +
> > +out:
> > +	kvfree(dc_extents);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	return available_extents;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extents, CXL);
> > +
> >  static int add_dpa_res(struct device *dev, struct resource *parent,
> >  		       struct resource *res, resource_size_t start,
> >  		       resource_size_t size, const char *type)
> > @@ -1452,6 +1794,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
> >  	mutex_init(&mds->event.log_lock);
> >  	mds->cxlds.dev = dev;
> >  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> > +	xa_init(&mds->dc_extent_list);
> >  
> >  	return mds;
> >  }
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 144232c8305e..ba45c1c3b0a9 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0-only
> >  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> >  #include <linux/memregion.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/genalloc.h>
> >  #include <linux/device.h>
> >  #include <linux/module.h>
> > @@ -11,6 +12,8 @@
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> > +#include "../../dax/bus.h"
> > +#include "../../dax/dax-private.h"
> >  
> >  /**
> >   * DOC: cxl core region
> > @@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> >  	return 0;
> >  }
> >  
> > +static int cxl_region_manage_dc(struct cxl_region *cxlr)
> > +{
> > +	struct cxl_region_params *p = &cxlr->params;
> > +	unsigned int extent_gen_num;
> > +	int i, rc;
> > +
> > +	/* Designed for Non Interleaving flow with the assumption one
> > +	 * cxl_region will map the complete device DC region's DPA range
> > +	 */
> > +	for (i = 0; i < p->nr_targets; i++) {
> > +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +		rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> > +		if (rc < 0)
> > +			goto err;
> > +		else if (rc > 1) {
> > +			rc = cxl_dev_get_dc_extents(mds, rc, 0);
> > +			if (rc < 0)
> > +				goto err;
> > +			mds->num_dc_extents = rc;
> > +			mds->dc_extents_index = rc - 1;
> > +		}
> 
> Brackets required around both arms of that if/else if statement. 
> (checkpatch should be telling you that)
> 
> How about flipping that and doing the (rc > 1) work first.
> then the else if, goto err.

Actually the goto err handles it all.  Just get rid of the 'else'

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 57f8ec9ef07a..47f94dec47f4 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -186,7 +186,8 @@ static int cxl_region_manage_dc(struct cxl_region *cxlr)
                rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
                if (rc < 0)
                        goto err;
-               else if (rc > 1) {
+
+               if (rc > 1) {
                        rc = cxl_dev_get_dc_extents(mds, rc, 0);
                        if (rc < 0)
                                goto err;

> 
> > +		mds->dc_list_gen_num = extent_gen_num;
> > +		dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n", rc);
> > +	}
> > +	return 0;
> > +err:
> > +	return rc;
> > +}
> > +
> >  static int commit_decoder(struct cxl_decoder *cxld)
> >  {
> >  	struct cxl_switch_decoder *cxlsd = NULL;
> > @@ -2865,11 +2900,14 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> >  		return PTR_ERR(cxlr_dax);
> >  
> >  	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> > -	if (!cxlr_dc) {
> > -		rc = -ENOMEM;
> > -		goto err;
> > -	}
> > +	if (!cxlr_dc)
> > +		return -ENOMEM;
> >  
> > +	rc = request_module("dax_cxl");
> > +	if (rc) {
> > +		dev_err(dev, "failed to load dax-ctl module\n");
> > +		goto load_err;
> > +	}
> >  	dev = &cxlr_dax->dev;
> >  	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> >  	if (rc)
> > @@ -2891,10 +2929,24 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> >  	xa_init(&cxlr_dc->dax_dev_list);
> >  	cxlr->cxlr_dc = cxlr_dc;
> >  	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> > -	if (!rc)
> > -		return 0;
> > +	if (rc)
> > +		goto err;
> > +
> > +	if (!dev->driver) {
> > +		dev_err(dev, "%s Driver not attached\n", dev_name(dev));
> > +		rc = -ENXIO;
> > +		goto err;
> > +	}
> > +
> > +	rc = cxl_region_manage_dc(cxlr);
> > +	if (rc)
> > +		goto err;
> > +
> > +	return 0;
> > +
> >  err:
> >  	put_device(dev);
> > +load_err:
> >  	kfree(cxlr_dc);
> >  	return rc;
> >  }
> > @@ -3076,6 +3128,156 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
> >  
> > +static int match_ep_decoder_by_range(struct device *dev, void *data)
> > +{
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct range *dpa_range = data;
> > +
> > +	if (!is_endpoint_decoder(dev))
> > +		return 0;
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	if (!cxled->cxld.region)
> > +		return 0;
> > +
> > +	if (cxled->dpa_res->start <= dpa_range->start &&
> > +				cxled->dpa_res->end >= dpa_range->end)
> > +		return 1;
> > +
> > +	return 0;
> > +}
> > +
> > +int cxl_release_dc_extent(struct cxl_memdev_state *mds,
> > +			  struct range *rel_range)
> > +{
> > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_dc_region *cxlr_dc;
> > +	struct dax_region *dax_region;
> > +	resource_size_t dpa_offset;
> > +	struct cxl_region *cxlr;
> > +	struct range hpa_range;
> > +	struct dev_dax *dev_dax;
> > +	resource_size_t hpa;
> > +	struct device *dev;
> > +	int ranges, rc = 0;
> > +
> > +	/*
> > +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> > +	 * get the cxl_region, dax_region refrences.
> > +	 */
> > +	dev = device_find_child(&cxlmd->endpoint->dev, rel_range,
> > +				match_ep_decoder_by_range);
> > +	if (!dev) {
> > +		dev_err(mds->cxlds.dev, "%pr not mapped\n", rel_range);
> > +		return PTR_ERR(dev);
> > +	}
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	hpa_range = cxled->cxld.hpa_range;
> > +	cxlr = cxled->cxld.region;
> > +	cxlr_dc = cxlr->cxlr_dc;
> > +
> > +	/* DPA to HPA translation */
> > +	if (cxled->cxld.interleave_ways == 1) {
> > +		dpa_offset = rel_range->start - cxled->dpa_res->start;
> > +		hpa = hpa_range.start + dpa_offset;
> > +	} else {
> > +		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	dev_dax = xa_load(&cxlr_dc->dax_dev_list, hpa);
> > +	if (!dev_dax)
> > +		return -EINVAL;
> > +
> > +	dax_region = dev_dax->region;
> > +	ranges = dev_dax->nr_range;
> > +
> > +	while (ranges) {
> > +		int i = ranges - 1;
> > +		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
> > +
> > +		devm_release_action(dax_region->dev, unregister_dax_mapping,
> > +								&mapping->dev);
> > +		ranges--;
> > +	}
> > +
> > +	dev_dbg(mds->cxlds.dev, "removing devdax device:%s\n",
> > +						dev_name(&dev_dax->dev));
> > +	devm_release_action(dax_region->dev, unregister_dev_dax,
> > +							&dev_dax->dev);
> > +	xa_erase(&cxlr_dc->dax_dev_list, hpa);
> > +
> > +	return rc;
> > +}
> > +
> > +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range)
> > +{
> > +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_dax_region *cxlr_dax;
> > +	struct cxl_dc_region *cxlr_dc;
> > +	struct dax_region *dax_region;
> > +	resource_size_t dpa_offset;
> > +	struct dev_dax_data data;
> > +	struct dev_dax *dev_dax;
> > +	struct cxl_region *cxlr;
> > +	struct range hpa_range;
> > +	resource_size_t hpa;
> > +	struct device *dev;
> > +	int rc;
> > +
> > +	/*
> > +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> > +	 * get the cxl_region, dax_region refrences.
> > +	 */
> > +	dev = device_find_child(&cxlmd->endpoint->dev, alloc_range,
> > +				match_ep_decoder_by_range);
> > +	if (!dev) {
> > +		dev_err(mds->cxlds.dev, "%pr not mapped\n",	alloc_range);
> > +		return PTR_ERR(dev);
> > +	}
> > +
> > +	cxled = to_cxl_endpoint_decoder(dev);
> > +	hpa_range = cxled->cxld.hpa_range;
> > +	cxlr = cxled->cxld.region;
> > +	cxlr_dc = cxlr->cxlr_dc;
> > +	cxlr_dax = cxlr_dc->cxlr_dax;
> > +	dax_region = dev_get_drvdata(&cxlr_dax->dev);
> > +
> > +	/* DPA to HPA translation */
> > +	if (cxled->cxld.interleave_ways == 1) {
> > +		dpa_offset = alloc_range->start - cxled->dpa_res->start;
> > +		hpa = hpa_range.start + dpa_offset;
> > +	} else {
> > +		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
> > +		return -EINVAL;
> > +	}
> 
> Hey, I'm running out of steam here,

:-D

> but lastly between these last
> 2 funcs, seems some duplicate code. Is there maybe an opportunity
> for a common func that can 'add' or 'release' a dc extent?

Maybe.  I'm too tired to see how this intertwines with
cxl_handle_dcd_event_records() and cxl_dev_get_dc_extents().  But the returning
of the range is odd.  Might be ok I think.  But perhaps
cxl_handle_dcd_event_records() and cxl_dev_get_dc_extents() can issue the
device_find_child() or something?

> 
> 
> 
> The end.

Thanks for looking!
Ira
