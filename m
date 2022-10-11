Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F443C4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Oct 2022 21:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJKVdd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Oct 2022 17:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJKVdc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Oct 2022 17:33:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D4192594
        for <linux-cxl@vger.kernel.org>; Tue, 11 Oct 2022 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665524011; x=1697060011;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=eSRSuXRyxZXzpJXhBIGvr6nDUVmqRaAqAdWxf0AMZKA=;
  b=mR4hhNZ6XeoaXpoUEiVgHiz3adtUfjxEToqssfdcOtcTDFnoyla5AqOA
   wVPyslUJpYiUTtL5yEInM0rlbH809Yc+9ZQfucpmFHAgD0eMnIhh9xS9b
   a05MmpiNszUa/TyIkTZXa9U6iScKL7dJUxgdWiUk3FLW/oXt1qY8A6NNV
   LDViSOiJBEqjq4F0GR53NVeAT45ySMijhycsjhWZ3I1oidHTylvTlbnVq
   9hnkggj6SqUTUN6ziXMNtBoYe9D69RJ5F8ThaT/pedK4uKt+6DezZhc9y
   m3HCJrjLlhjhjsmE2Nw8i8GWp/ZI0DWZwMWmSAryf8wcmZIM3Jc58Y1oY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="284357898"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="284357898"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 14:33:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="955501160"
X-IronPort-AV: E=Sophos;i="5.95,177,1661842800"; 
   d="scan'208";a="955501160"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 11 Oct 2022 14:33:31 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 14:33:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 11 Oct 2022 14:33:30 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 11 Oct 2022 14:33:30 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 11 Oct 2022 14:33:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpCLjqi7k5Gt6YwyipSI526SJJaSTxmVmok7kQee3sI9CVf8Mm0rsrDvd3vGwDMCh1o2EO1iW0rI4oFQClluxWm6vN+yxWNZSRcv01QHnky2Hma0IyaAmhHtKFnnqfgxajCQXiaSdkKKiJNSgimm7diOJtq9VsI2BsQKwFW5osUh+MsE1QX5NF2LGCwzsExZmwXTepE7JdP+2ZgbZl8Y+mU1oFJw9kUXUJe/bgkUXmd0IcJHPMHNGkclJtcrjCFAQB62qtJh8MiJS2DML2AFhZgBIFb77RL3uMenFfUNPZmFee/3DKo0mzMhDIjAfsCDUsWJQ8FD8kvTyv7/47NVtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/Zr3DZ4Bw5vkebAjEMOI6tYq+Law0JCSTAnPQK1bvA=;
 b=eyzXhvjxvByD66e7a1S+eiDOJq9f7C7FJGIV8oSAjfjZZ99AWpJxyIbr5xiqGN6U+CxVFNX6KPeT6R74xDW6efj19rtkB7OBAnxgt1nEQ1RbvvJzIwQcYzK6JWWir8i83MHECj7QnfD3NuJ8sfMCZZqw/lqjqBntn3gbc9EfROhH8sDgMHVvx6uvK7oJWJepkkp0xV2Mg32CWuDSM532yg3k8NjeADtFUXhrwVdES7GI2VapdUbgT3+EbNQeobr67hTEX1G+cS/QmY1g6c6Pq09yrQJUAI4FpPQ3IxNRjP5d8iOZCNcOsMxavXz5hrzyOyAfqM4zI7veALaAGYCoDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB5025.namprd11.prod.outlook.com
 (2603:10b6:303:9e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19; Tue, 11 Oct
 2022 21:33:27 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5709.021; Tue, 11 Oct
 2022 21:33:27 +0000
Date:   Tue, 11 Oct 2022 14:33:24 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Schofield, Alison" <alison.schofield@intel.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "lmw.bobo@gmail.com" <lmw.bobo@gmail.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/region: Fix null pointer dereference due to pass
 through decoder commit
Message-ID: <6345e1249d59d_117adb2948f@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220818164210.2084-1-Jonathan.Cameron@huawei.com>
 <2e395b9e710cdeff65dae276cdb4957b43fe2714.camel@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e395b9e710cdeff65dae276cdb4957b43fe2714.camel@intel.com>
X-ClientProxiedBy: BYAPR02CA0038.namprd02.prod.outlook.com
 (2603:10b6:a03:54::15) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d6aa29-00c2-4600-b009-08daabd03c28
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f0Tjta9hZR8bBqDG13/9C+YPcgBlJIXTenrtSsg/7DuSRLG1xL/7+a76DtxIAf0KGtNkDPHoT1RZuD8QKf23+5TctDJ16HNKVo+SqTxY9H3aQRSkLLoJRbm5+MHVWv3pDABwnIX9kOICHycc82Lcw1I1nVcAErYqwBY3PwH4gXbF/h57LmJ7BDfJFjA2HU6ITD9ZaSLHFP94aNRe8gU5DbOOg4JQ43cXw/LqYbq/ratoVWli0u0B89mmLTD3T27saxLWpUdTj9NHO4lDfOfFL+0BdbnbZWi1g3v1tqI5So62NQipphHZmk31SHy/WokU3w0tl6WY3fCQPCh3SKLbS1pMeSy30KfVExmfKbRiiIkW7YxFG1Qs0b/sv8StCVh3J2aRbLXAEg65z9IfsBBdW1GwIxl0CTDixKJPUWQ+WVeRLiIt4XS7TwASilhWGq2TDa/G7wBvRxwQUhoeidd2hUiNyuAFHgSSO1sOR5aE/Nwtfm/OJbnzjJRVUPyNP5Brp51oEKtqblDwZ316MgIJ0Amb+gzdsNmQWZWkh8tPRxA1Isz2E/N2YsLQtGke1b/kZF+GcwOg7etmw2u2nE2UsQJ0v3F1f0P+x74u8KY9kbU5QyivSy3n/mOskDMb1S7zdK+timY0ZSQZj65zwQd+HGPQdtj0ik0EDQ8p3JWQEe5Iu2YqTKadf+cBs9Ijg/qe7pI+nxwzPSMZa2niwKLJ8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(5660300002)(8936002)(4326008)(66946007)(54906003)(316002)(110136005)(6506007)(6486002)(82960400001)(38100700002)(26005)(6512007)(186003)(9686003)(478600001)(6666004)(107886003)(66556008)(86362001)(66476007)(8676002)(2906002)(41300700001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?l8cDdqwW0nYx67+zRjpctH6SOZ1Qq3A7yuvjUst3qic6JhVTPGko7XNlon?=
 =?iso-8859-1?Q?FyqYH3ZsAc+mYgDADC+Tn0/1FklU3Y0r4qB5L4gERAJDv/KhwhzrTA08cL?=
 =?iso-8859-1?Q?eNPT4UyYVD5Ok2ufANMg0NsPzrV8RHdGnKGDF1uU7BUFbEeiEC71m0dfJi?=
 =?iso-8859-1?Q?gNz4l+XW1fipD8eg/Mm0T8o8DaCnk3FnwMRgO6ShfolnBkYETYWsjt+3ZF?=
 =?iso-8859-1?Q?0UpKyJTwBBaX0h5xI+tTZ+CGbsOUf5rRjUGcAhVA3We6dhkpOeqQZrSS3N?=
 =?iso-8859-1?Q?OcLoCRmY+ady2u60ldV5dC9AsbFlr/Y6ZCqoGULUimDhJBNzlsDB3FLvR9?=
 =?iso-8859-1?Q?H4ON9bbUPo2Xjs/5Pi4dh2gHIWeM+q5BU/3NGViqYFWQxenqTS0xetQcpv?=
 =?iso-8859-1?Q?HkBoEMks4DL44Wc7f51tYLc95ATASYqYxwimb9zkbLWtzGFR7mJGV+pjpX?=
 =?iso-8859-1?Q?j1d4nLmiizgOTNUhjgRFw2+AFZovcWyMfaDnMr+mFLYeCPiwPWKnGXz52s?=
 =?iso-8859-1?Q?McWXikA3ovPKlqWpKuIgDrz6xIE9QAE3BKtzUQnaK0Lif7VWpgt9IlqT0s?=
 =?iso-8859-1?Q?HdX+FibxF9DAlBqIwvoT0unaT28Ig7TmerLOkrwIzS/AOuhRwXXOHQ9Ht2?=
 =?iso-8859-1?Q?rTXvPGZYI6ezE6JrEd+Egv5euRza06/ZW7AsZuit7V0ws43B6giOQxdv37?=
 =?iso-8859-1?Q?KyKuf30y6xzlN0Sg2Ta5hLR1fibJc7uXl+2b+cMw8eio5iXxKCGPxuj0BY?=
 =?iso-8859-1?Q?6N25qZX7D+uUkhLBTkjBD2R3312BGYu95PAxgcTh/BfFXBMT706To2k+e8?=
 =?iso-8859-1?Q?N5Iw3vcKtIBlfe6cGfNrlTFp1HaFJJbVgi8NiJ7c2Y9uRTNi4rYIp6+XIo?=
 =?iso-8859-1?Q?yyKBI3Y3YJ+I06WlvSFHQ6W7t2ms00P5vPVejtCKeeC1QJm0TAsEB9F86o?=
 =?iso-8859-1?Q?WroF2w3nDY9nOuqIgiSahy6fVZUYpmYS6BRo6VvmrHLscEEN3MzWKJiAuT?=
 =?iso-8859-1?Q?GClpYESO8dKdHOzNHnpvW1/gKGJgwC31nQvd13TL5iyfGyntrZ0mg/wNDM?=
 =?iso-8859-1?Q?bHnecoABxcnPlFKriDiTfBbBkPEHDmS99W+mL2sYwUjBBV8mtF02Imp8lp?=
 =?iso-8859-1?Q?AfmKOKB2UW2L1d2ZZ9MO63rFU/QKZ4yFnOCie7oB/cM53SW/QGIvmgMan6?=
 =?iso-8859-1?Q?7UtEF0vu+NbB/2QIvy3MuHE4J3tAbP7k+HXHxiACn2RmEPCtHllHZtjbl/?=
 =?iso-8859-1?Q?LgVTtC9jEwlvbPifPK5IFl918yMcqxnt+D+Yxp2UcQ18+RHlnE+LKuXde1?=
 =?iso-8859-1?Q?fkpI8NZnAsUsUCNZcsgyw07Z3FZcAuqLyAbXIRbcb8ULCdZygSJya6gLH6?=
 =?iso-8859-1?Q?h/SVGL1VL8q+gdLQuVYUX3By6hh/iew/m9LbwFt/V0zYl6T7+siQfMrL9I?=
 =?iso-8859-1?Q?mT0MAbW0yatLOIR4+6BMtkuC5b/t2yMZj1UqJlNp1dDUyJobxHbXUjBJu9?=
 =?iso-8859-1?Q?3y5ndGUVLAa5cbTs/fewf8Mq7IbqUJ7C9LW9YjY/NpJg7zsEA4o/b1/gdP?=
 =?iso-8859-1?Q?rOYq6h7gvng8THA9LRtLMFd65g+Sy30ffgmOeju4OuRXnyd0qMuPSqDTkd?=
 =?iso-8859-1?Q?Sj9T3jzHdTp1Bsj6Ed3L7LgtMucmdtUUppYtSP6uySgjcFmTA2FT15dw?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d6aa29-00c2-4600-b009-08daabd03c28
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:33:27.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z71HUg7Ey2tU7n23YdFZ9JZ8nrbfGUKYnH/wHxux7K1ikobv9eHDIw3PRgAfEWPzSSRM83zhWXFQe3vlSG/qAbx1QU6PAe9OLSAbNnam/uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5025
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Verma, Vishal L wrote:
> On Thu, 2022-08-18 at 17:42 +0100, Jonathan Cameron wrote:
> > Not all decoders have a commit callback.
> > 
> > The CXL specification allows a host bridge with a single root port to
> > have no explicit HDM decoders. Currently we assumes there are none.
> 
> s/assumes/assume/ or,
> 'the region driver' instead of 'we'?
> 
> > As such we create a special pass through decoder instance without
> > a commit callback.
> > 
> > Prior to this patch, the commit callback was called unconditionally.
> > Thus a configuration with 1 Host Bridge, 1 Root Port, 1 switch with
> > multiple downstream ports below which there are multiple CXL type 3
> > devices results in a situation where committing the region causes
> > a null pointer dereference.
> > 
> > Reported-by: Bobo WL <lmw.bobo@gmail.com>
> > Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > We could fix this with a stub function perhaps as an alternative?
> > 
> >  drivers/cxl/core/region.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Other than that, looks good to me,
> 
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Thanks, incorporated the changelog fixups.
