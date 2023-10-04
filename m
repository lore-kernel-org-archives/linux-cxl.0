Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF77E8FDC3
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 01:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjJDBJv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjJDBJv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Oct 2023 21:09:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9A9AB
        for <linux-cxl@vger.kernel.org>; Tue,  3 Oct 2023 18:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696381788; x=1727917788;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7qo9P52CeT25gxSsCuLn3m6Zv6RdH+LZf8+x6qdTd8g=;
  b=A/TbwmTmuabWxdts0oKpdDE8eLLWqcvf/VLsmV8AQc2aAcNOwLAjxvdk
   Xc76+B5/r55o1O5hVjOit+REcy065zRvoC2ZNytpMeKTHRQ6HaljYoXEr
   MOLkDPAXglmuokQxOAXjeiPphBUTyv/dh61afnd1iekT7NpHArQyfV21B
   +mUYS7V09rwz9QG9wkZ1T6i7p5EC1fPYGXL8PHhEZK7avlKegCpNlcFDT
   YB2EJfspcFT3EoRV1JH7KgSrtATBRpBCgM45eUuIpjExyyvx19V85yXde
   VoAMQsWp3xAU7QQD+6DGM+WFJtrIWc4QOTXxIsXmc2RO6MtmjaOas/TLp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="373359076"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="373359076"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 18:09:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082250835"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="1082250835"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 18:09:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 18:09:46 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 18:09:46 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 18:09:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 18:09:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPO68Rww1Nk7vwtGvpED7C0uOIWuXDIBWKkO41QvthMS3Gry4Pmxv215ld3A+m/u5C+/oFMumzljt2chFSn9bWfHxbwBRtLOzWJwPPAncM3ho9ZTbVc28ZUsF5vck+q5NPHSE37goQPvb72jObRB6RNyGuY0CMveuGriSaadHurivSEnBIUgRFV1ijIk6z/1Cx7ELtFYY9LYeW+tPKrq47K2rzMJ7OXClh52T7BSlbZREEPQbB9M/y6owJrIoptw5fsjqrd6FgJrT8zjQhx0C1gBf1gWuuRjE1fX5g7KQEMlAvWdS4wrmWsR3NZf6mEcgaC25+tWCwFvJiWrgLIIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su4sZMZdqCmtw2MvrFpLFWvj6+l9bxK4yeEZ3/hh+xw=;
 b=U5T/hYgO7727FlUow7m6yFnwS1AM6wsAlBu9oRpKBfIznFHM9tz8ooyosGaYtAXDkDhLZi50/UOW4uvthI8FeSdejBKe85hoBnKfWTAsTTVmHcA7MEyQ4M5a1MBvc+SdTrdZ39fdYI2bRNQD+TlDKLukt5c2Rc7cwcK74OjCFx/JGkQrAvp4l6L/Gzfe1kagETXnfE0CwiguTtWMlODEctzTBBIl3/Jk6LYLbtcu+kxlWs37u4GSCVLny9FhganSxFVxVCg0vnsRkyO9aOgFQuOtXHOPT7mGMafC3Sznhi2W3q/fzXAyj9w8Y55KdVraMHML13ZAHFmm8x26H/jQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7100.namprd11.prod.outlook.com (2603:10b6:510:20f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 01:09:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 01:09:44 +0000
Date:   Tue, 3 Oct 2023 18:09:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
X-ClientProxiedBy: MW2PR2101CA0032.namprd21.prod.outlook.com
 (2603:10b6:302:1::45) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 359bcd28-a4f1-4ecc-1451-08dbc4769810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuQgbwCerejdWUrxuiYTEaDMyShmI8utevT0QaYrgEdBGr+YSeI1g8/VUat0ntif6yCY8VtRLxki0YiJ67ViDsRXyqNkOhsu7CXdLGg1rMKACdQdVlCth+NKXk32JtI6LIetq/pTzoYmSj5eK+hV+L2KfeWU41dbI7ES7MUZNFsTHWVIAQv9vlQF/hUbH0HjwcdMkEUJFS2x3+8iu68USRVLofLXZ0KmI2TD87y3xQIsNAbYfBQFwltZJpib+jIzR4XBY/TD4y3NUukiwFA+e1s9Ingo63+7Uhqw1pB9U8+n2ktDCqrDnRIbqoL9Yhx6fYTTDSggNpX+PRjiK1a+ouefFSmlhqjYReKI5rGHKF/odMkfuNjUzBV3QpOCtmK4zo66rJvL0TLIzJJGnH3ZoJL3Am8Bx1M9bayxhOgyUhJM5E1DX4TtWzy8wxqDUahgDv23T8hHE1DRlRGvAPR3R7/Lpj4SAzIogus71CKQAUJ/iJ5Oehjar+cEtA0mlJdJu2/VTIEYOXUd8mVmTtKhGsnQpKWDJz7vaJHDwS/Euo9c1MWWIhThtxa/s5PtFCpN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(136003)(376002)(366004)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(9686003)(6506007)(107886003)(478600001)(316002)(83380400001)(26005)(6666004)(6486002)(2906002)(66946007)(5660300002)(110136005)(66556008)(66476007)(54906003)(8936002)(4326008)(8676002)(41300700001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wqOKh5b92l30l9blsMJL2RlJeblOe685cx7PoyeA+LEgl0pAzfKTbXOoyG9R?=
 =?us-ascii?Q?HtdpFC+NRx7LD6HPuKbTN0UnzMMZSlw/XWoiXs6ZJp1lrn4ExBhoDSg1+CG1?=
 =?us-ascii?Q?ADsQtV630Xw6VC+IzBJnsCUN6MCzQDliZM2YZp8tTp3ibG5UbqC2N1KSYZtE?=
 =?us-ascii?Q?Ym/a3MCVBg1hEEGMcwBtvs7rZ+Fcw4tdEGnFZiZ8OMG8QJL+pQOiHzjmnc6J?=
 =?us-ascii?Q?Ph4vcuoOZ52chYrPv7dzVf6mL/Vv/rsUx3pz2hT6WpqlDpBqPuutbZRIEDzJ?=
 =?us-ascii?Q?rEth8zQEJeGe7RStm8JQk8uqPtsJE5LBWDw0cfcwIryPy4VL2H3mOaXASdSi?=
 =?us-ascii?Q?QS9+E0LVpSKgeXtj82woQekuPZM7Ist3pz2uOjS0DZifGJAA5E+5yKVe9dhr?=
 =?us-ascii?Q?MpWwsAC+dt37HeqJSX1g1XNL3cYx4d2K2vVOlmi4qnDrUZQBRhC60unc+cAw?=
 =?us-ascii?Q?BWAQFvBonzXKEddQxuracxtYOco4o0BJKKjm9X5tN2lDhVIfIq8jgouG1I6U?=
 =?us-ascii?Q?kCcnH2Qu5cFIiBbTgRFiS7poFUyWRVqSSyIQU2XXLFcXnvClaJ1GjMe49Azi?=
 =?us-ascii?Q?9Yuld38iIeF2/dTEhBqgX341dQjUdlHi3XqaGqgGYQVs9HCcn6Asqv70XHbT?=
 =?us-ascii?Q?MAwSbzABvLbrvwpn5eBJVsbIJ77RvfGeX9YfEHRYmac66PPrp60g42Yx38rn?=
 =?us-ascii?Q?73og+JMBbJUGdE3BtPTE93H1S3fq0Q2OvUVRGxeL4OxXJzZai/ccowKaxmXc?=
 =?us-ascii?Q?6Rjh7bZ6LjHhOINtkrpQrhj+S9YRFNmW5aOWmPblP0S91MjGmlXymZmNkCDh?=
 =?us-ascii?Q?W7IhqXEHiAOPmRUvB4lwvD1Mqgu/T5cZXZMzh/OJx6tVjwAXH0LBlzH/q5D8?=
 =?us-ascii?Q?01mAzcI5p/2n/zqzrmDaG1jtpfbnA2Z+1zQFBAfIwesm4gSULaxcYjpO04Dc?=
 =?us-ascii?Q?gAcXdYLx1DRMOSqsf5S+6DGAA54Blz5jFcZ2kzDoS+0I3c/ki7YuEfvFg491?=
 =?us-ascii?Q?yZwi/MRHVGr6fNv/9vieyGt8xvnQ7rup+Arz8xOb3Re3iF0MOKYMPoWEWcMx?=
 =?us-ascii?Q?iBXae/BDkRyiBM5D0//2GpwRQ/rS/a7ay4YkD7tOmznI3bWqqn+maPVDyzK8?=
 =?us-ascii?Q?vVxLtccutLP42wibwpPD4DctY4gAb5rPXQwfdcUAtDXo524MfN5+QhOkwh1e?=
 =?us-ascii?Q?d4lhnwKmv+fG4J9qQn7do65CO1e/ijQS7mm3eX+2ZTHibtGZolWx153+x3k+?=
 =?us-ascii?Q?g2DW6DW85F9o2Kl/ScNbq3mPio6g3SlP8B/8HIfWYWnyKsL2KltrycsBzU5V?=
 =?us-ascii?Q?S0+a5ZwKRHe79N/mVHKWgXBQ3GPsR2FJy0Q6nFqCVmoqnnXyAkUPu1uAS7QI?=
 =?us-ascii?Q?66EZCi758TFHo5Yi0NcH9yFw089wC1rMOyuKbrMWiMeFRGyQEUMR0GFeqBY0?=
 =?us-ascii?Q?4c2Coc4qtwvzHiNXrWqS4lBVUSN51J2IvMMDlg51EVkCMF4SIkKWPfJTVmHh?=
 =?us-ascii?Q?hiCdGFh7u/2cERb+qD7hs0gR6XYF3VeQHYxxUutf55TXb+bGcjURlN9ASrkM?=
 =?us-ascii?Q?8Trhht4PcSl1yPfhRVwE0tVmGgLKsO8UkiOjGwcHtjSiL/Rg2+R05tB4tpcK?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 359bcd28-a4f1-4ecc-1451-08dbc4769810
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 01:09:44.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAlJOzALbawg8RZL8HlMOWSeHhzNYhxWMp4b0XnmqReZtVH+KQ3UoeTiA0IWqdPPz03v/bC8c/oqfixDJ7nb/o+xdnkAmRsAShWxpNadwws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7100
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Fri, 29 Sep 2023, Dan Williams wrote:
> 
> >+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
> >+{
> >+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> >+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> >+	struct device *dev = cxlds->dev;
> 
> This wants to be dev = &cxlmd->dev;

No, the notifier needs to be torn down in the cxl_pci teardown path. If
cxlmd->dev was the devm operations host then this notifier would need to
be setup from the cxl_mem driver, not cxl_pci. The teardown order of
cxl_pci ends with @cxlds->dev as the devm host ends up as:

cxl_sanitize_teardown_notifier()
cxl_memdev_unregister()

...otherwise if the @cxlmd->dev is used then the devm callback may not
fire until device_release() time since it is possible that the cxl_mem
driver never attaches to trigger the typical devm action around
->remove() time.

> >+	struct kernfs_node *sec;
> >+
> >+	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
> >+		return 0;
> >+
> >+	sec = sysfs_get_dirent(dev->kobj.sd, "security");
> >+	if (!sec) {
> >+		dev_err(dev, "sanitize notification setup failure\n");
> 
> Nit: Should the error message differ from the next one? Maybe s/sanitize/security?

Maybe, but these things will likely never fire, as devm_cxl_add_memdev()
would have failed before getting here. Maybe just delete them?
