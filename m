Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61ACEE7C4EC
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 18:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233599AbjJDStC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjJDStB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 14:49:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E03AB
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 11:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445338; x=1727981338;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ppn8/TXkmFwLkwV92gIQXW5Zs5LIq51Ds1Lsg/KTN6w=;
  b=jvSnatp/+pFHfXSAacUga6m3VZjGJnaX0QixkVCB2QvPIRTyRo6qROdr
   9duvhhCRRkLn7U0JP5XapfQIrVpk6xRqBwacJBtodLOoux5QRW8FwcqDL
   9kkhukEo7CwP1AxwP+0VluHfCN3atQpE0Z/AYy7ssGFZg6LAjfaIzd6If
   tx/9e6rM6xvemVJUNcLyzciXBAlshE3em21srrOWe4ovlSrT3ZAwrIo5I
   vF3qDplod71ZL2+MC+78MJUTYPBLMZrXdz+iXxbUyEn3unVqJNw6eXchA
   C2w9NDHC87MGznuwj2i9o41ucHiprXxsrW4SkjjmkpR703Vs90Dg5OVSV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="383172809"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="383172809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:48:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="780911566"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="780911566"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:48:57 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:48:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:48:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:48:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:48:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SBmKNb3ElkKDULvXw3+keJXYD6bHM3ZmW+/hykLRTZD8E5Zu7qTiTxp6uZM9NRkOwp/+nagEx5V+xduF/veOeboBrO9l/qGiygUvWAbZZcET61zTDHkO7aZu86BMaNxWVkodeB82SEB8CK/U7dFsD3kkXe68t4f+EZvRKkbwkWOzO4pCdrsffCiSLso5wnpKVeRadNykC3GaQ+/OTE/kvJZpqdd8V9iw7ks86OUtEs05iZqnRGsxJg9KS9pfYq/wTkTN0HRYC2jnxGB796I64ZRsoiDmyM7weI+s0UkKzgeWhHgJbLtStA7GgVJgp2Ch8hweK822NxH0TvbHuj/hug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZT3pjlB32CsI8umvQxygjuLLKd2ID/xjUFDeH04iOqU=;
 b=gbQypJOJ42JWuAr/sASeva5zWStlx5ix7b6EUlyEV1NBdadyPNwHDSNtUkzEWF9sz1HuvPEymX6jwViISQh6orKsBGpgC3MxkN4XFbhMR00T3Gijhw3CIntNwEBrcbArEsesY8ZProLmOAVdfINeIc+fEhfe36OovzQ9P1IeRD9WtugOz8UB9ekeMctwBXab8LLxxcR2KXP5kyRNhUX7s//7cX7JYq599iD2F7LpI/u+dm+9uLLrQwO2daASmWC4Gq0PNMWPkzRCk5MZOJwrC++R9TtVq0n5Wpi8xLnzYlK/bdB6sXuSLXyKU98j0GM68GWp/4vWJ+v8YuY0iCT2yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7452.namprd11.prod.outlook.com (2603:10b6:510:27d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 4 Oct
 2023 18:48:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:48:54 +0000
Date:   Wed, 4 Oct 2023 11:48:51 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <651db3937f59d_ae7e729490@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
 <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
X-ClientProxiedBy: MW4P223CA0030.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 72d80f33-c16e-46d7-52f5-08dbc50a8f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: riRLRjT6aOLXj6V72l7z57rtuT0dPJ4o5o73Mj9Oin1aai5+ZQVYIVrWt6Ry4xLGj9b5lLGxTf2mPDdX0gnHGXdlEPirdNInvtHgP8hA0ZMyzgn+AofQcsXvX8WsbP7u9jH+Dk88T8uHdcsIe3zgGyLcip2A943b2QHhE6Zgyk1sA1dHUbHpCDNXKV2R1C4XjI0OdESmrJ2vq9MRvkZU83CcuigdsX3iuJDwAgGbnn/ZiCKjOsxlj4aTrBAWJu4hcR2Dt8klB2PtzgIr3veCC5yRKtk2pxiT/i/Q+NeACtrQW/gyMhiPEkkiT9Vl5Wmlv9w6NdX88kbfjuy+1uzghLAv/tAvOzBSz+im98bFypMP0EK5LWDcoK/8fOYDoTgej2WKr1n2MldQDemOHAlogZkuiOgETHe6DbkfAbXadyGrd+GrULR6hSC8yyRcVioIQ8ZxLGiXqI9IQb9gP8PvWRwQ8a4VGG+Rw0Yc93Oj3kyQ8ej9NAOXP5+emlq4Kb+VPxUBf8Rvvj14WjWJR2zI626l9Kb10QYu1P9MBG5Pd4L1pK3kneLP/elTQsp2buuO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(110136005)(66476007)(54906003)(5660300002)(478600001)(66556008)(6666004)(66946007)(316002)(6506007)(41300700001)(9686003)(2906002)(6512007)(8936002)(8676002)(6486002)(4326008)(86362001)(82960400001)(107886003)(83380400001)(26005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wn3nxB/U5kcmEd/FolldBnSTZ+L/F40FmYHDHuNSUKEpk7KxBUHknctmflDl?=
 =?us-ascii?Q?mVFaM1oo62TE40qbg2cc01ngEw/hq17Vrl8K37wM+/Yrxf+WNo6MBTqb/PGd?=
 =?us-ascii?Q?NJUcdmdyyQrZWdIobpfz9ciWXEaoi6Z7NcFcBbTA/T38+969vUWcV1cx5wt7?=
 =?us-ascii?Q?gPuDGGsji02mGf+y0UhRfX7BtUDSZ005cS5r9pR9if8HWrdNXV/QFE8phDZM?=
 =?us-ascii?Q?iVxOMjq7uLYZhmc2XKUxc/pWX/RVg1KYO5cAcqfQT8UjjBt3fcX1pLuxuJU5?=
 =?us-ascii?Q?PEwRRCNZteJnKoULLcmFULjmJnIZ4sgNL1h1g31J5ks/7CgPQBw0uPhuNNwL?=
 =?us-ascii?Q?Gp/KR+Gg0V9Gx83wy0YmNMXMN1FR4C8RqiAbnBaMejqpg144bD/dtbGWkfMi?=
 =?us-ascii?Q?oAn6yAvp6urkjxrvebt7cyedWjLiWyKlHrPadhmfAb0z8b4+cnNlsg6C83oK?=
 =?us-ascii?Q?rYiM7zWz99g9I0d7rvxupdraDOTlhEBCtTeI2ZqcHhEoGuZI9R9LVJZTUZvx?=
 =?us-ascii?Q?zriKC25iwkHWui5dLA9ZuhJlxWKMzQs1lzIcyupjoPQr2oD0w04SD8BBI5jB?=
 =?us-ascii?Q?FxxQsyyQnKofn2M9/IlC/0RaGCammgBXTnirsQ0rg2tho+sexiT43kz207LV?=
 =?us-ascii?Q?2QHSUGMRE8xKLmKGbr4nTnC7zShZYKup+a11K24/JLISsFxIYFdVA+enYvN4?=
 =?us-ascii?Q?bjmihgbPFXd92ju+kdYAJ58La65pu/cWXtjI/+G/KROOXZ+watSWYZEbdqNB?=
 =?us-ascii?Q?geeiYV25iznAVpjS04LE96axsQqSLSvLpyE0YAjpSynrpCz5I2iLDzAft7H6?=
 =?us-ascii?Q?aWNT2dRFvlWBZv6b7xuswoTYPF7JZzyyJiHSJHJKssCTeXz9riar3G0f9+A3?=
 =?us-ascii?Q?1Ob76b4/GULeQPWnC5aQwq4EnZNikaVu0Fk61Zo8ZU90vF+NTmdZEf1tpFpX?=
 =?us-ascii?Q?9vgItnyw6886C+fN4NHP3JR9XkgPoVUow4U1p/STNHe49nPk0Q9+wIFBTryt?=
 =?us-ascii?Q?bjMHI/zh+Kq1CwJ/a3FSW3nZFPubCRKDe0DsW47BEzNHS3G99+dZ0o0ucrrM?=
 =?us-ascii?Q?UciyInZsKJEAO4bQmI6o/q+qJPZ5uGa8kfbzapkq5JVDbFWeE/oeWGQpK3bW?=
 =?us-ascii?Q?FPKsrMSaU0R30zQ9zjK3DyEnumaPQ8TiqT9SZeEYX+ln9ssgO8mb1q0QCm+n?=
 =?us-ascii?Q?O63JjnrIDB2rvHrtqpjSgjlCTf4TAFb5iBJPAk3CC/h+z3oa4crPRKGJlx1X?=
 =?us-ascii?Q?xDZ8aHyQKmKpQfz0oSnxWI1CcSaEwHXg2Vn11xxF0nfXg5zSzKNA6hlfDO8T?=
 =?us-ascii?Q?gHlBHo/XQQri+feI1N4mGuW5BYbYibGcV71Uq29xA9/XuUiqTcyjwFywtrKn?=
 =?us-ascii?Q?VT2MvKSjwY3IMCuUcr9DImQDSOq2sRA7QUAO5sC97YXLjYXJQrsp4lCTBuUW?=
 =?us-ascii?Q?Wx8Wa94/uxs52om5n99G1BYQrna7jO9hYy0IGwGavvRL+6/6aX003RjomV6L?=
 =?us-ascii?Q?mCZAWoErHx3/3Kio8k5g4k+mGtHBFfYsc/yrNohOZH0bHGhdgEtfkRsBh8To?=
 =?us-ascii?Q?UFYheuqVG1U10OoLqbDZDaotjc+2jx8R5XCdmlLgnqXWOHA1WSS7QbdHVoRd?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d80f33-c16e-46d7-52f5-08dbc50a8f1c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:48:54.5339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmUl3ZiJYKgRzhe2omsKFQOejD/n5AXhqti/n2yBWJoQJq1yCfN9MfSoyGaTHyZNdtjUJHJ+0rMH6uc/1e8EVJ9fpLo9eLCL4NsUmCIA+kI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7452
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 03 Oct 2023, Dan Williams wrote:
> 
> >Davidlohr Bueso wrote:
> >> On Fri, 29 Sep 2023, Dan Williams wrote:
> >>
> >> >+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> >> >+{
> >> >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >> >+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> >> >+	struct device *dev = cxlds->dev;
> >>
> >> This wants to be dev = &cxlmd->dev;
> >
> >No, the notifier needs to be torn down in the cxl_pci teardown path. If
> >cxlmd->dev was the devm operations host then this notifier would need to
> >be setup from the cxl_mem driver, not cxl_pci. The teardown order of
> >cxl_pci ends with @cxlds->dev as the devm host ends up as:
> >
> >cxl_sanitize_teardown_notifier()
> >cxl_memdev_unregister()
> >
> >...otherwise if the @cxlmd->dev is used then the devm callback may not
> >fire until device_release() time since it is possible that the cxl_mem
> >driver never attaches to trigger the typical devm action around
> >->remove() time.
> 
> As is, the first sysfs_get_dirent() fails, fyi.

Yup, thanks for testing, I am using the wrong device to lookup the sysfs
entry.

What would it take to get your test scenario into cxl_test... or at
least a recipe for it in QEMU that can be checked into the cxl-cli
tests?
