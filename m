Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D99BC25B06
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 01:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbiHLBCz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 21:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbiHLBCh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 21:02:37 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D474DF3
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 18:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660266156; x=1691802156;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=v0NBLmdbRyjLhDzyKxGpufVBEdvGmR+2mtRs8DYAy8M=;
  b=iRqTNIkTSUNlvi+yzlR4j0NdrBFVpiID2KF6hqeCK8UHzbH+C0GXrnfu
   Vq3VRK0M9a98hvHbV/m/7iIgGuZC473dbPh7qfP1XGekzSUIik0KWdXqP
   vVKVg1y0+Y62tCi8vdK2yn0ShuK2tkI+xuREe9ZWQ/SClRA1wGqTWhy7P
   N1QC0e4FRS/TSzjDvKdQxtO6oFUeoETA/w4xWm73C3LCDx6uwtSNE6J5U
   M0Mceag3mrgXvszFKgKm/PJntoQkO5XBkhHbpvBGQyOvcgQLrfuYEYALn
   kxfRB4VKTmC35AJNUMKHdbclhato930OAfGhRZEWaY7WuS1MkR5+Gs/sB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292758007"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292758007"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 18:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="708824502"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2022 18:02:35 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 18:02:34 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 18:02:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 18:02:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 18:02:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQeNimxlQQQJSx1tJA2yaMcLd1zfBdlgVNfAVyB+p1Y7YAiuNjZrjaTEGXe1fX5zDLxMLOrFhcMKZaqyFms9Iu+sKNlze7J4d99/IT7+4h9BJcrhXG5MaVGCRjXKS91t8A8DhOI+asQtiH25Z9vIgOekPNcUydb96AWY1J9TPupLIo9sWl3DQf8l+gse/jnXmSUubcRU+a/LeDhMFYPBH8whTMbm9W3gtoqpAMwtVKk7YDpPtm1PwrXizreT2yecYI3tBHw/w8UD0TshCjm8x9yCBsY0vr5jp/e+lNGtk7R7b9UiBKro27fsfTlsBFDKTtDSwkgl8twjZxIt5yZ/RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONUh4mLe9zFfVANxlT8ST4dQF/Byc0uZjmYCuGW3qNE=;
 b=H1GJOm6o+A2WGzA9SjSxol8fYcFSiOWNRSf6+XpLtYwwLHkqZ0kxQ7MXQLsPEjPud08537bDHqy1RY4tMUbnstVs3RjzfXKY/luid+DcwuXj9wjqp0x/77Zxsc7VMOPjtws0dJYfAqIowT5naoy/ghZjXysxMCQ2xXQwj6n915f+phYHWaHp5BXYlDuyPhbdqOwbng05pCb8CO0iyJu5bLx0jHXCWvXV7hoGIusmHHmuf8sQ7X0HCTHTM6mK/AQX8EiNDoYLWKqZ0tAiqn3EiK+l3QBV8oJ6eO+r4aeChjGzzDqP+NAIYjZhOVoIQ7IhR30g3PNzNpHGopXqe2hDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4143.namprd11.prod.outlook.com
 (2603:10b6:208:137::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 01:02:31 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 01:02:31 +0000
Date:   Thu, 11 Aug 2022 18:02:29 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 3/3] tools/testing/cxl: Add interleave check support
 to mock cxl port device
Message-ID: <62f5a6a52419a_3ce682943c@dwillia2-xfh.jf.intel.com.notmuch>
References: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
 <166026222564.1454405.200833694547817544.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166026222564.1454405.200833694547817544.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: SJ0PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::30) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16d175b4-1965-459a-bd57-08da7bfe557b
X-MS-TrafficTypeDiagnostic: MN2PR11MB4143:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L/rDDUnajWkO5bbWozWwPwYlK5PUeSdBxWzk7xuMA0eK3VMlMnpk+4pqWjnfjyNX/GIykHM2oCYl4raXKMg4M5JwXi+BUCqWwBvCvy/2q9ZlC/9MMI+XIE4Gk1k5/cY8QcFIE2wXMWjVKgbAQH18vviYwN/Jqf6gEKuoY36a3vy9ZUfVqEUNDMlRzLrOEDwib5yWwDM+LoDyAr/VFPLDVFs9GdHieloHqZJ722G1roHqlGWb8nLmpbtBQGBcTpPOuqm5tT9CUNEgH48AHx7QzAFT4NGl3ZC+AcK1fePxpeKlWXFeLHRl2ghcbSgScPuvQLfifoh+H0qS2qmP46itG5ScNvWv7mIRFSz3BBjtZDrIhSnwgn17zpvtQJlRwL1d95L8Nz6WhV1tA3LAeWPjjXVsUiXquiEadlbzMSH9/DoggWOj+TOe49TW8sev9zoBwwGrmQ1dHgcH8TY+CvpEp3b+DBJ9w1uNcXZWLavHQxW9+AgqED+eOtta5wM3RV7aKRu/Xueb3pPnQmEOzTxoJuYXHxIN7iJpZt0McWG3sqqi2nm8rM8UApGSWHHtVOddZ3bWSDssk23P2Vd04tTzhLsZCu3bAhJcJUsOv4J2ULWnbWLhpbgMUh8qfdWfiCagRXhiy59DoUqCbk9STEKGxZ5w0jJRS5gPf2KAlxiQ9iqWjLVvBSvmyd2Aq5XMgBNK0WbV2r5Hb9EMGylGqxiMYrzqAHn7oHetDFOwW7EQ/ohHzj1jw8HyMkaQeIIh3EYN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(83380400001)(86362001)(82960400001)(38100700002)(478600001)(316002)(6486002)(66476007)(4326008)(8676002)(66556008)(186003)(66946007)(6512007)(4744005)(2906002)(6506007)(26005)(9686003)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dwirbobztel1BPD8wyqNldePa3y6jSFTmuzidDrGoVloPqrkopzaZi/P2O/Z?=
 =?us-ascii?Q?3WHe+sbsxXQBw4sGJ7RKIm4kPTDbRIZmeijTjgp+8Ji2olAMCQzx77heXbI1?=
 =?us-ascii?Q?ixXEUsBtN3Ah4iwKH2rqFHqylKlQeOULGbJPKLU5ncxKLp4ri+hCTtzLEQMu?=
 =?us-ascii?Q?MICuEHnI9fXb1rP/OutSg/1bwIuPVmbOZCVGM16hnkPICtFof+KC0VuJ6N//?=
 =?us-ascii?Q?vX7tMPKFq+YigRolBUdpTI+JrWbN14iTeHXYVGQJ65kaJGr/FPX32pVPcKbx?=
 =?us-ascii?Q?T1vCvLqA179FmFeRleOQyX3ISr5DkyH7xP6GDHwnigFAJZYEAOt5Xe54nQVd?=
 =?us-ascii?Q?hRBmnecQiLBn1pc5Ss0aDJZevG4V2fcNkznz2826vB1DuAWPluKbjWMf9lJC?=
 =?us-ascii?Q?DXV2ziI0cQqat3b02lgP1kdq7XkqfIpIDw0pT9lT03kH9Iz5tAei9O6Ze4Gm?=
 =?us-ascii?Q?gVpyVIsmwO6QrxKoVYNxU21W4wRHiH5LGX3xbWfGyTHIU2x05GOmlUevYdSP?=
 =?us-ascii?Q?HFi7Sm8T2pMyCzVjMvvZz3TfNJMuukcUYdF5WQ6kJvL9WvaZoITtgEwH7ceA?=
 =?us-ascii?Q?PnAzCKmS5ZwTg2hIyCQzs5LmKj6x78N2qesXwG4Yr69GKAq6ITKxo0CBIV+C?=
 =?us-ascii?Q?liaE0TxdNCBhqN0qqlRjX0sVEyGL4df3tpSkcK4z2q/7gRlaS0KZuNpmIwnu?=
 =?us-ascii?Q?Mvkgj63HvRU1vwfhwgTRxDZh3LfRQCJT8MDraCuTX6yFPGAkmqw26sKLuaB1?=
 =?us-ascii?Q?0u2yFTQsVw0fnJpzOGnv2a7KqTf06tysudSDCoRZYcoX9efi4VRV8C8LQtiT?=
 =?us-ascii?Q?sfpG72QoWT/7UyKXN/FKwgQOhmojQGHjR1BX+6VTuFFGic2xz+vXxsHs6rwF?=
 =?us-ascii?Q?lWdlDxHUAKBXNZ6WaNRPANpmD7NLzlB8LIvVOEw4rLMp8nRCWeGzP4U9eBGx?=
 =?us-ascii?Q?oLCBgvKZISszjE3qJQmzIwIv+gtiEFZYcY6AxHk5LxAos/O/p7uG7e7+gbSx?=
 =?us-ascii?Q?VQyslQy8iz6FZ3aTsXUkDpoBQAiBxABDLGZ+WgC+dJ80JVP5B99VAT5r3udY?=
 =?us-ascii?Q?ewhfAzitPpjljPq30nZvw5r7SnZ8tS2eL0NX530DBj28bZCHkjHZN62J791x?=
 =?us-ascii?Q?weRYlBRjWcvzN2t81VYWJL57MFSafdugq1bdqEtUL63SGpna1qeDZs6ZX3hY?=
 =?us-ascii?Q?1czChpuTSanysaD0EGvnMFziFfn32mC+NStmHn02Il8WMe0qncXBjQIU1B0x?=
 =?us-ascii?Q?p8WKAuA2hgkhjATeLrnnJmk/JXZqCwQhgKfpWwDEG9F4Osa5fAMA6UysICpL?=
 =?us-ascii?Q?MtxPYf+hnmKnC43eK6Sc+oK9Lv4F6UdEJiAPwbcQYllIj0tZLQJbmgxC8OC/?=
 =?us-ascii?Q?JA1fUJjYtKk/h0sFJNC2gZUjRj3QMi1wnWYT/vVQluyg3/GoJipyRHR9Yiku?=
 =?us-ascii?Q?UJwWWAL6MkWImlJTKXD16VktKxxOeVpHhJUOX+hMXZPJswVFV4dWx/wqvCSs?=
 =?us-ascii?Q?lQCfTRjujSuTsBQZVt3zQ/rS6NsBlkQZMx9LsF7roctV5n65YxwKDYioT7OC?=
 =?us-ascii?Q?Wy1ZNAokIdkfLLsIGH1/ulZZMTpx5hsI1DaEFFaa1lEvWcdBW+YhxF0rmkDU?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d175b4-1965-459a-bd57-08da7bfe557b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 01:02:31.3522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKkYkJH0uwTC7fn/lIH26PMgn4gW7nuQffhetuBq0J0hU/g9SvrvRrwIA7jWT3C6VL4PXH6xsX7k0NHALamCu4FmuhhPkf9cXt+Q07IQIzY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4143
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Attach the cxl mock hdm to the port device to allow cxl_interleave_verify()
> to check the interleave configuration. Set the interleave_mask as well
> to support the new verification code.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  tools/testing/cxl/test/cxl.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a072b2d3e726..3ce353a20b80 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -398,6 +398,9 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> +	cxlhdm->interleave_mask = GENMASK(14, 8);
> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
> +	dev_set_drvdata(&port->dev, cxlhdm);
>  	return cxlhdm;
>  }

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
