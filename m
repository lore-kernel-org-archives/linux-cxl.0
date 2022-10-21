Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED59C433FE
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Oct 2022 23:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJUXFB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJUXE7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Oct 2022 19:04:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2FF0D9965
        for <linux-cxl@vger.kernel.org>; Fri, 21 Oct 2022 16:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666393495; x=1697929495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=A6OqgwJxUxpXDbNLtEy6KB+x9R83VGAY2Nk225Q3WTY=;
  b=HTQQpTpSLOzFrbDOF/CfZoen4r++WzM4qXeZvFx17Ddf28RfPDSlet6+
   rvYBNZZ2pG5IexONwsodXGeCldIiOAVplhNxXue7fQm69BB3QqItPpmBH
   4Z+7NiZPcbh1aHh9qZj6kMHW0PwrHemycrIo6qiUNE89jFfAC3qewxsQu
   6XKk6VhcrrZQzdzZk+6yPakl13FRPJTdmWzMyKDLFkzt1FCQsBnhbeEfX
   f69QGK9BMKGndxDrYp9wS/MiVweZW58l0PBh6nLYrHgZ5sRtclsPXjl3N
   JAOW/CUr4TL0emkRM+KQPs9yGCnUoT+aDUkzACLqLC+WAbDFQs16W3ikR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="294520524"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="294520524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 16:04:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="773231256"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="773231256"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 21 Oct 2022 16:04:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:04:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 21 Oct 2022 16:04:53 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 21 Oct 2022 16:04:53 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Fri, 21 Oct 2022 16:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odhJGbFfRc3yzvh8McaoltgDmjwKJa0OJAwxNb5qJZdO0lwtauGWOtkbmK5K7uaJdJJdHaBrdYlQ7kX0jHuYGOF750CLjjGZTYi3mn2iZMM41jjwWSzsZD1F0ik9LHuYZ9XAh2/Yc5Pei6tyHU6bCCftjYZFXmnxah7RBdncoGBIne3SUce3+zfndtdjtBaMYwQvY7F27uVz6fTXGt+Q6eX3ULiMuT97c9iJx+zKFUtqqbtdGTCofOxqsN8RbspUkE/+oxfGSyLBlbU0ntZzOw0uVheuhPn1w2FOF3PXeYDj0LZKLRrqD5bBecHX+Jd1el9nJsNC4d8d/1V6iSDwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7+TYEOCOyGV1QJLEU7cPKMbpKtEGMyLJfZ6bl8jPOk=;
 b=OZ7U9qPLEtBazJZVhCr4SyaARUtlSC+RjMHzrjl/L07dTQfbOiE/i2xGSYsiiCo35FcY0OET6ed6zh3haRoHFDTRvsZ0QUVEDp263+WKIjipkDCjKRlWeXU7O95TEgxWl+GHNUJEftIqbO2C9A37H2xKZ9ffSW5igj4N526zhkz/PI0J63nCoTWHvMT4SuJYIBUgekfQImCj4066c15PnrXURrbSLfPpi9XBBs5NpY6MYllBO9kqqOjpQdJkqtwhdb6QLoQWFaftNGrrCFpTHuPmhTcdCFGKkpJ5ds51mOR0VpGPmLLSCuozdnaeoZgMaIiVmyg5SlsRK0VFEowkww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SJ0PR11MB5583.namprd11.prod.outlook.com
 (2603:10b6:a03:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Fri, 21 Oct
 2022 23:04:51 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.021; Fri, 21 Oct
 2022 23:04:51 +0000
Date:   Fri, 21 Oct 2022 16:04:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Fan Ni <fan.ni@samsung.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "sunfishho12@gmail.com" <sunfishho12@gmail.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [fan.ni@samsung.com: Re: [ndctl PATCH 1/2] cxl: Add root port
 attribute to cxl list output]
Message-ID: <6353259068166_4da32948f@dwillia2-xfh.jf.intel.com.notmuch>
References: <CGME20220930212330uscas1p1363cbba1dc87b5442317e74fa861ae9d@uscas1p1.samsung.com>
 <20220930212315.GA2896523@bgt-140510-bm03>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220930212315.GA2896523@bgt-140510-bm03>
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|SJ0PR11MB5583:EE_
X-MS-Office365-Filtering-Correlation-Id: cf4c48bf-a5b4-4ae4-185b-08dab3b8a8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8mcH24n9rdZS8ysuBTaI8t+jPt3U3T/hOHxC70o5qwmuepw0eyOp6yrrD6I2lLo8LwHsqwx6TtHmZMZ7P48PUrHkgKPdz6ekcqXCYcyQyQUnzAzfjG51eetWk0VOqF+mtOwyIeaIc/FGDLfTIkOJs/pCrzuFWgV+ubsHE99RXmmR+Q51bqbJM7n0Rq3g3PhCByrZ6Ys3PwEZMWMkET8UijlZQJaTjcM7cR25vLMTntxtz8Xw7XWCXBztIbEcTx1O60FPVnKVqgRYyxfzLdFcTsIdWWTFx+MOU6Q9t2KYNqZtXNDr5DGrc0BmYigGPW6WfgYmD07F+XBDcAXwf3YtMRiWTiMWgOdE73ABNX7fRKgAOEmV0At43HyBRVd+POqWuE0F37DpRCr6ymPd/puV0oga4udwH/NWSCdprf7B/c8yY4CFLwfgLh3fZdnvGW4WZR9CQDQ9j7La7O4Vj3dXSvlXndN6/v90pnSrV6f2kL3u37kFtEE/YehHAw13Moa9yU0g/PeFzD68yeowwDK8YY18Mz2D6dfgSjztRWTNkFyv7TfCj1U5qbHbrGUkSBXi2p+fEi7wOnuQafw8+WZ5MPQccm2vxZstbF3L0LNIiDf/EAn47+rIUQtfJLelndurjHYUyTYjwYxuDOHIgLJurDwV7aBnuuBtAnyUMXCHbJayWEqloI7GlTKjgb28fF3LhyUd4gBycJK+2XV53QTLpLD7vanlhnlOkRNlUBKhjTsYaTcUQGEsrTayvMuUa9rWDEjN7TwgWuRoXNaQyXhJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199015)(86362001)(82960400001)(38100700002)(2906002)(6666004)(5660300002)(9686003)(186003)(6512007)(26005)(6506007)(110136005)(66556008)(54906003)(66946007)(6486002)(8936002)(6636002)(478600001)(316002)(8676002)(41300700001)(4326008)(66476007)(220923002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5H3NJgzHkVcTF+2KLRI2iIDpr6S91zp514OG2NO6EUHQTK6/t8s9ldu5Gxwo?=
 =?us-ascii?Q?NcGDfhzS1Aa3Ce6GTE424upBge68Gfb7EHehrnbQ25u994CixBuB0aL4T8RB?=
 =?us-ascii?Q?d3lfRDkuGPE2DrgmVewF+Th3KgZd6mvTiNOJwFhnGMUbaSMT5ddBK1N5yp4K?=
 =?us-ascii?Q?+a6BC5TCHinJKn+tGxsW2mEAex/FePe4e177P17cwAyDs2rI47Jwqh+iWLEN?=
 =?us-ascii?Q?/dlrWYIaRNbeuId7Y9kCp4HUMTU3r35z+zSjkqgrE5htxp6s40ehIptoh2qc?=
 =?us-ascii?Q?wIFxPWcE0EFTI55oulUaI2GbS8XkCRKo910eT9Cz1pIyTxw9E2oVMCujvFqR?=
 =?us-ascii?Q?cVCqhOlbZGVswSXrY7Evm6Z6wfVUd4Jy2oW7Mc7upcu9TdnWTgYVi9hvoadM?=
 =?us-ascii?Q?6Ie/DWa0yGHX+7jpaRx/+2WHvVBAvxWQgxBmEQk0JztP3KJB/KFPW3UowjI+?=
 =?us-ascii?Q?eBBbaqe6Fhvf8h8yygjwMrTjfypuA0v8efe0Tbt9fI0+kX6BWUGCOGXEiKS8?=
 =?us-ascii?Q?4odKc6RXfLmPY/tEE2wGXQ0J0zfpgHsI/CRMYK4NMOoonmL8E3HG9SKs7Jqu?=
 =?us-ascii?Q?81wTvTdBGSM5GvBl5kdrkB9Q5bHlvd5IssC09DEYpXL+xzrrEDrI5+iys87H?=
 =?us-ascii?Q?xCdyg1ZoI+KHhu5RDO3CSQnT2wqZt+sHMh+SDojfnKcDna0s1N9eJm0Wkzys?=
 =?us-ascii?Q?mE3dB3JknS8Pj5cUPOXfrwdH04q3KdGEhdh/bxX1qemZD86yw2l69a0axDRx?=
 =?us-ascii?Q?yONXVRWspStv9JdW1QVTTyBWgb4/Va9DaRnyq7qF2YbERWOqfUF1ibfB8qZd?=
 =?us-ascii?Q?kFG3U9JG/hfeK5bfT7t531oiJ3UNadcu4QDsagLBHWemz33YEJI2N/CkVTA4?=
 =?us-ascii?Q?GR+9g/YmtWjDBKwAbpIbYMdaH0SOpETMduYIi0kQZol1ElpshyBQAzpV+0BM?=
 =?us-ascii?Q?kNao0WbbHEkuRuVjz6GxY5E4mXBjPdYQfzYUYHKtUbbu9OpxbmuvT34fyN2p?=
 =?us-ascii?Q?DbXtfcluC+TiQpAbI9YZ60RQOax36+2690mO+paw2ZEd3bWX9Qn4KqAF8utN?=
 =?us-ascii?Q?C06ZiiVYoMSaiKGj4BmJKCLRVs6BDXIlLV/HTZK0+Hja84I0J5gK9+RKd98D?=
 =?us-ascii?Q?zDFsin2SxJytnGuu1h5qkK+vzEdfxnbuqyCrY1SuPRbEI864i2lTaif9tZrB?=
 =?us-ascii?Q?juVVMSdfUE1petCwUb83lxivHkyUKdla26GeJxnI6wppujKaEugepDL7MgSr?=
 =?us-ascii?Q?KlfeDdb1okUh4klsB3KRTBtlcKnqfHki4j9aPBtpHuRdiBHhPUB18jLvWkDL?=
 =?us-ascii?Q?9fXnhJN/EUlXEKih/LYfEgVrEXml6qIKAbr+Qna40zrrL+hviXT8VLCiNyHO?=
 =?us-ascii?Q?TWBpm1AWTxwMJdtGL4TpzR88y9M0B3xOM4iGwbH3iZDSOOOovwZOKs3l2AFZ?=
 =?us-ascii?Q?sPvaP5Mgf3BTU/V62PUQ4yzqj4siLzaPrn1h3rQiPSrfVe/IV2X2L0IXQboX?=
 =?us-ascii?Q?SvR+y5EwprABMVcT/Dzgj+lSsgkSFzTL9tdOGOLpcvQl9R2yK12hBnONB+rb?=
 =?us-ascii?Q?6z5BpRBd+RN9+662BeO+KZbRATGR0jvce2ye5zQQURwU+6MJT7xOtL7LEJSj?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf4c48bf-a5b4-4ae4-185b-08dab3b8a8b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 23:04:51.4147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/icXrf30AyS9YtcMdHgw5Bn/c7pEiEh1eZdq0BpKukpwfZ+IVKHSfbuNkB4u5vpLlQ1yWeU9GD4WaHT2n+kAifdPDj0dBJQNXtCrsm1gmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5583
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> 
> 
> On Fri, Sep 09, 2022 at 10:10:04PM +0000, Verma, Vishal L wrote:
> 
> > On Fri, 2022-08-19 at 01:54 -0700, sunfishho12@gmail.com wrote:
> > > From: Matthew Ho <sunfishho12@gmail.com>
> > > 
> > > This adds a "root port" attribute to ports and type 3 memory devices
> > > located under a host bridge indicating which root port each device
> > > falls under. Previously, the cxl list command lists the various root
> > > ports as dports underneath each host bridge, and displays devices as
> > > being under a given host bridge, but did not indicate which specific
> > > root port corresponded to which device. Adding this information
> > > helps to map the CXL topology.
> > 
> > Hm is this patch actually needed - the json output can already list
> > port hierarchies. So would it instead be possible to have a 'walk to
> > root' helper that the graphing functions can instead call each time.
> > 
> > A library helper to get to the root port each time would be better than
> > just adding it to the JSON output, as that seems redundant.
> > 
> In current cxl list output, the dports and memdevs under a specific port are
> put at the same level in the hierachy. As shown in the below example, dports 
> and memdevs:port1 are put side by side at the same level under ports:root0 in 
> the json layout.
> With that being said, information showing which memdev is attached to which 
> dport is missing in current cxl list json output. If there is only one dport, 
> that is fine, but if there are multiple dports and memdevs under the same port, 
> with current json output we cannot figure out which memdev is attached to 
> which dport directly. 
> Adding root port info to the output can help users better understanding the cxl
> hierachy. In the patch, a new attribute "root port" is added to memdev and port
> to track the info, if it is not desirable, we can try two alternate solutions 
> to achieve similar goal so we can plot the complete hierachy.
> 1. add extra attribute "home path" for memdev and "uport" for port json object,
> 	from where we can extract "root port" info.
> 2. If we want to keep the current cxl list program flow intact as much as 
> possible, we can create separate json objects with root port info 
> for ploting hierachy purpose. However, with this apporach, we may have 
> duplicate code snippets.
> 
> Which approach do you prefer? Or you come up with something else?

If I am understanding the problem correctly, I think this wants a
parent_dport property for ports. That will work for devices attached to
root ports, or switch ports, or when devices are not attached at all to
know the route through a port hierarchy.

It just so happens that tracking parent_dport is also how kernel 'struct
cxl_port' instances cache that routing information.
