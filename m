Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80A3C77B61
	for <linux-cxl@archiver.kernel.org>; Sat, 22 Apr 2023 01:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjDVBeo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbjDVBel (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 21:34:41 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A1E26BA
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682127280; x=1713663280;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wUAbNNs1lirFL5e2prz7PkHUbvo60e7cyDceh7BLv38=;
  b=lrSVDKbgHcSB5urAANwTFRGlrgm1BYWrJeHBodwm7V787cLknleBtgFj
   Be9o68Tlat6KGJGRjvyERh47/4ZLcLIjOLspeuEix7/VnIH/HPhxNK0vZ
   oriXlBYi/DvDOvTXR2WPRucdfWMsPACxNJyvgKMtC8CDTLbSdJlyz22Tc
   GzexwtMd4txSRNWO316UV0ggmBtV1tjADEJ7uA/X7eaX/zm6HJ5M8qoVi
   ymFqUtJKBVMP/U0Fqe1zQ/xxNS2n78DhGidU0TutJLS2jH2bqOdV+DHv5
   TbKkw62A3yemgtcfjtZIUY2ohgTUetX0PWQQSmfKV5ICrblFPqRXcYxQf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="326446231"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="326446231"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 18:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="722951645"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="722951645"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 21 Apr 2023 18:34:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 21 Apr 2023 18:34:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 21 Apr 2023 18:34:39 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 21 Apr 2023 18:34:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h433HKpIZwHzJ5dnGbal/pHV5WheGiB80Uf0Qk08M+3f+i4jrIwxMQQpmDZhb65cXjQSvplq/tnKFxFriIWCW5cmWVZJaRRzhPAg3Dey5HqStuwr/j2bc4v6toFQX86MlHlZuPvWZ7i2V4iheEgFspG/EOXkTjnRgyhUkfTaGBRtNd4iYiuTzkrk46y3vCtWn9SO6+znhIQp3zHh0QQzoXeCeh4gv8WXyuGlO6NtenDw4CGr6Y/nOaOE0PRtZvDdgfOda/GP6r9uCs1hPwKHpjoAMM1h4orcj2a07VJ+5d8hM0UEm+RCKvsmFawwO3xU84wTvcI6CWwmWTN6nWVBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y34uweXacOKKKLOUKAwWDQHqRQGFd+IV934F1nQxDt0=;
 b=ZEI0DfYRvUKBMXdA9oxo92Htt+HUn+FQqZDofaTOhK9X31zrmKIXzwbi9ySIOGG85aUgg5RhLIpCmSOSNP0EQPMYkp1hcmRS2Qqk22BTOGu66T1+0+9LAkqtgXmLjVQ7gmgMNRygt2AwmhhDEM8fLRzHZKOywkwrkdpAqvjjkqKei3xLe22bmS6rfvUaIjwjWckr+urmkYESwtwxXc8zbLckIh/7GMP7MHHMRnpDjVTocOZsyVFCR4S3dTTatVeHwrU3RD1yLCYWRwBKhN/dOJbLgYu4oB45xvV5czhKFIC/RYxBHxw2HbMdLCahAyP0g2AKEHkWz+MlHTdEFNbwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB8165.namprd11.prod.outlook.com (2603:10b6:610:18e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Sat, 22 Apr
 2023 01:34:34 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Sat, 22 Apr 2023
 01:34:34 +0000
Date:   Fri, 21 Apr 2023 18:34:31 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Nabeel M Mohamed <nabeelmd.linux@gmail.com>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v2] cxl/pci: Set the device timestamp
Message-ID: <644339a7175c0_1b662941c@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230130151327.32415-1-Jonathan.Cameron@huawei.com>
 <Y/Y19p8hqgYGkkKK@nabeel-linux.myguest.virtualbox.org>
 <20230222162700.00006d0f@Huawei.com>
 <Y/bjnb0gmmpkjk8r@nabeel-linux.myguest.virtualbox.org>
 <20230223164227.djns4grt3qeydmn6@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230223164227.djns4grt3qeydmn6@offworld>
X-ClientProxiedBy: SJ0PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: e71cb91f-4888-4514-f8f6-08db42d1b996
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VFo2kGbg+TZx/ZPhQ6m85RydmMFHzgFUgyyagqOUMdxiKAF470smxLsMRmPhhQ1KJu6ujXH/ugkVBMqaXQh2QQKq9LCTXDOelXhXudy3I3EmScrbmzvAWw70GpOdKNirlg3qCijGGwOit8iTcFZwfCeUGZlavbT/B4TVzyqs2dKIjePQDa4I9J+PUXJ6XZ/VuXQsNNSK2zCSECvRlGU2erlwnPznFVvHDDfvb1oOzhC6Y9nrBf34m+VW/RNgN7/46op1BbBaNkO7z+PkBjtM6O4QTB9w5qI/vWWnrkF6DnShGO5Ehhu3pbdlCrRhwpyRx7vuLZ/Wssn0D2vXeUVbO/gaGNuHbQczfDfRbCUqIj7+hvl9D0hLZQbOyM2EDYFur5nUdzrjuuQqXcX+598ltvUXRD76RXHaRrQgYdwkpT8lO2x/kEG6sLSWmdmmf+yttqpiv2Fee8sEbtJ1fnn77Itqewc5zAW5dZFQGZu6638/wdSUi6wORwZmQ5niD2YwABmbn2xoDTh1lPgndFmYctfRulGyXQY4g3BcRqdvB2VpY/qkpIjli5BBeIjZYcu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199021)(4326008)(316002)(110136005)(66556008)(66946007)(66476007)(54906003)(478600001)(6666004)(8936002)(2906002)(6486002)(5660300002)(8676002)(41300700001)(4744005)(86362001)(82960400001)(38100700002)(6512007)(9686003)(6506007)(26005)(83380400001)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dgCNxem4HdTxbpEOS1AA6bAU/Jq6/xjpZniRpRhkhLvGBlEkU+XfTuXD+4c+?=
 =?us-ascii?Q?7+5evdFX8mtlY1bDeB9pzK3ZyHZBJfHO7KBwZ9ZuHFo89YuU8z5BE4rbMTnP?=
 =?us-ascii?Q?olPCKGQi07dFE57hhZQCsGJkkkx71iZKttXGEK1kD3qQDX6EknLQ18BjZ4P9?=
 =?us-ascii?Q?WwZqpZywatE7y5/dtyIJd21PBraVdQ75ZnHblq9C6i2AucQ6G+CDFyr3SjqH?=
 =?us-ascii?Q?EFcN8F+24ThucFDFvwjLzBMxTXT+HiDDZAJKNnXwplvQClSGqA08BQuScoVC?=
 =?us-ascii?Q?XLxfQyiRYORrhbiKgBas2WsrpLWeRKkAxi2z82J2c+SdkWUsPcv0mxI9XNbU?=
 =?us-ascii?Q?uIo1QgkStRXLbdi2UFZbNqnn1q/I8gUYG9SFQtQH/ePTM2h6+hgYJKwA+ke/?=
 =?us-ascii?Q?/A6R7ua1SXLPFMFyWRJg1jDibT1QJXtsMtXI7A1Zm5QXG55Q80znC/mvSi+U?=
 =?us-ascii?Q?xV+8tEMP+FJ62UtwQ2s39jM3Gi+NqFSX8yy8FUhwkcBlvQcZu5Bvc5Zf35EH?=
 =?us-ascii?Q?zD9RSvuaZWbnilrny68UwRbmkvhJeyS+oMx4beiKvQx2DqN/mxvgw0uLKh66?=
 =?us-ascii?Q?+59LwCP1wecp6f68riug0MCbD8RKCXcwJcdJdGX9K9U0JjTPVQGunYUDrzc4?=
 =?us-ascii?Q?RFE5O5hISFhm8MXt8ODTDc3m6ZIpA7q78c8nA8eqmlbYln30024310sGehon?=
 =?us-ascii?Q?adNy32xEK+pvST4kzT8UqhJ8ujC3vvbzEWQGnSaekWQVrfHScOmcGxuDNYtu?=
 =?us-ascii?Q?1235RULDdA9Ox9JNJQbFfL3kRSC9Xc+WgoNN5R3YG22hAcxlu7pZYm7iL1iH?=
 =?us-ascii?Q?DSS9lnbibnH5OS3DGnDtZiYt0XuxKojgMjQCgQo6UrULVrYIcMYx+SH4DjqW?=
 =?us-ascii?Q?ZDn6kZMvm7mY0QyGsrmH1WK9wybfqkR/HKDt/v8BEiR/s13u/ohYNLOFYwtW?=
 =?us-ascii?Q?CtLETHAWCjf/xexi920e4xsSe40Orvj1HQVbeFx2ZdkFK6b/jKAqMwRDkvqU?=
 =?us-ascii?Q?aws07cXLBycnMSKjkHd8oLNL89ISHei+S4eK0XAM9mNI1abDwEqRebOOoZT2?=
 =?us-ascii?Q?CB7uG//nP4T5knWcRHF2hng1KDAPTVP3vUCWiYeaaBi/V62OSDFVrrN0zSYq?=
 =?us-ascii?Q?FLmG0RNpx1+m/0gIwepINMedE12iwWxY0iFQEbYpmHfQL3atyhy5d09txp+K?=
 =?us-ascii?Q?1x7zUHKRR0mqs9woIus7zCEOkeHbqbWibpNwaPhA4ph3MRcxt56a5+cv5l9Z?=
 =?us-ascii?Q?bXKqMuc4x3i1LF+CIm0pW1xz6A271FzvD1PGycshYTScWxfAIEZjWHxMnmE+?=
 =?us-ascii?Q?AyNkF8vhL3OguY5TIiFqgo18qd28UCvjYvSKIujjDt3eCyjyjmYy2k19NI9P?=
 =?us-ascii?Q?cCFGL2FzXEEu7+HatRcfc/PHcqMRpAn+5mmdRM86wm1nQzghkJqQp83p5h03?=
 =?us-ascii?Q?0dP2L3F0QR58zsM2QL8r3smEO+Y6H0EY890ZGsI/IOhDaVJ4HDXC/BelgZWw?=
 =?us-ascii?Q?MtBYwtWc89OHaDaOMCRI+3NhenmIO1Qv9Sl+A/5V8UZ3oas2kAsd2mRPA2PQ?=
 =?us-ascii?Q?zI+dKR2JD7PQvv36SUxCue+/lZgD4a4vmnEMt8Z/83N6Kq+06xTNJZoIeC4v?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e71cb91f-4888-4514-f8f6-08db42d1b996
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2023 01:34:33.8517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ntJNlf2+I5RARt9TCOQdlecM573258ccC5lvns5+rkV8O86QokBSBAScmMoC3rFnhIpry1TwnITSTP++OkUSTWR71lqLom9Atn0kcf00NmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8165
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Wed, 22 Feb 2023, Nabeel M Mohamed wrote:
> 
> >So, I'm wondering if there's any checklist listing the prerequisites
> >for submitting a patch to the CXL driver - for instance, requirements
> >on adding new tests for coverage, any existing CXL regression suites
> >that the patch must pass, etc.
> 
> Btw we might want to support timestamps in the mock device, no? I am
> aware that qemu has both get and set.
> 
> --<8-----
> [PATCH] cxl/test: Add mock test for set_timestamp

Mind resending this in its own thread? b4 can't grab this as it's a
reply to another patch, and the above is not a valid scissors line. I
tried manually fixing that up, but git am is still not happy:

$ git am -c patch -s
warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: cxl/test: Add mock test for set_timestamp
error: corrupt patch at line 16
Patch failed at 0001 cxl/test: Add mock test for set_timestamp
