Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C67E7C4F3
	for <linux-cxl@archiver.kernel.org>; Wed,  4 Oct 2023 18:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbjJDS4u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 4 Oct 2023 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244934AbjJDSzS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 4 Oct 2023 14:55:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13001717
        for <linux-cxl@vger.kernel.org>; Wed,  4 Oct 2023 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696445687; x=1727981687;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hgZZjhXeGt28MXJHlH6ugXsf9KWDJfAdxELo8WVdEk4=;
  b=gk5m+YK7MzZy0mN7kmyUsPT8c16PoxV2BYIrdWwNdiNW5sDsk5dXiMPq
   /Cw92G44tGjPKSUeNDLC13dDsFhjUzPF46pFZppGld1BMdrxhe6urf+bZ
   zGNwknPin9zz525rQeZETxHJDjKEtAAZg02RoytMa+HIBSw7asEripVaK
   yvHctvDI7tPTSwci4I7SBiDrX4prvBx2l1mhkBf0+5gX4ACA6iT0SFIwO
   Pes7oRa/WqN+nwFyY81TEfOOuI64B3F7xQWwlkshTo9r9Lcyv8xWRjIPN
   qoY/LC3FDTkIIF8axO7/SPhGXtt/IwrEaTVsSB9SoSFZpGPeb4ffx1HgN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="4835703"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="4835703"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:54:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="745097221"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="745097221"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 11:54:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 11:54:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 11:54:44 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 11:54:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cLrUPsOBYvcrXwLmaYTovDJTSz4kkWZTapEnaOV4b2CMm8a4MgdheKUtCs8XW4mdc8sXj6s00pf/HOO+nVkSutJ16v/IFzwhhbD7FKk02Mh5xZLt9sFTpEdj89exkDyQPrlMnglJgBDTUN7UTnS1YQNGcGWiyX+zACVFNY93oyAGDK0mpRz/+4zSB6jKH4h0+fy/n4C4OqGd3zKvg3FdenX7S80ODLS+4viHSOQbkc+Uj0KH/D2yVhcB84+d2ryQ2ci4SSbHsFszwcqyXyLijl9I+lvccxxm3ydlmIc+KXrHmbhfowneVbrrq3DagWI9FK6Vz/0Hq3WgaIM5xlry8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDoT97w6Wr719X+Qdzu4APailUwRZNUI69UyUN+oK3Y=;
 b=BWWMYAowyF9WLwwZFa4EPTxBrgt+eno1cmmrZtWuPv2bAzwJdewx+xtgdj8+Qx3gAxw+8O35z4X+KnPc2jNNsRdqDQMx0hBlF4Fun2wXBM+gIISDyUz+N3dZY++4Ngy5I2ZMqJ6QP26+O92wQBO1WB19fQEbF6RQaYnl6VPnytQ6uqI268M8l1HP/QpAiquY4Zwnz6DiTGblMrdP1O07u+Ypy+kTYMHc2CXFDJYq8nUBioeZAmSGqmJ+8kKQImJ6Gr4k+cHC1XexNaspYFZ0CFqm2fp+yBL2OhJ91ES+NXVNvdkAaxjAkTfWc3wZEiRUpBdPvQmhC9/N7NfutXNOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB7498.namprd11.prod.outlook.com (2603:10b6:510:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.30; Wed, 4 Oct
 2023 18:54:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 18:54:42 +0000
Date:   Wed, 4 Oct 2023 11:54:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
Message-ID: <651db4ef262ed_ae7e72947a@dwillia2-xfh.jf.intel.com.notmuch>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
 <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
 <zs7jliubdhd6e7eabzukvale7bfoltk7ja5lwvvue2df2n2vol@4nhsl2gzdcfw>
 <651cbb54d1ebd_ae7e7294f1@dwillia2-xfh.jf.intel.com.notmuch>
 <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <z43unomoc6f542g5qxgc3zzjtrjdfnqckywd32jzavyzcouana@buy5wxxsnuty>
X-ClientProxiedBy: MW4P221CA0006.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bbe8ba-ce4f-4e69-2f88-08dbc50b5e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3XXYBGqK3GTasXnbQq/AyvRN+lBUSL8wcfJts95+T19YTotPStwLuE6JehiLW5Lofgpm6uDk3HNbUxyOzNhoe3oEMNuY94mMLS67dqkUskpm1pmy13TO4igOwDCPAg2QQXcmEd3dk9jbeDIVYoj8RdaqziACiEI9qD/9fl5vnUWS9CY0tsPh2M1kbO2hBKr0ScSzKsClIjENyqj36ivqK5A/5Gkj5M5ztSgYQxPLsPZRJoOA4+OCl3A2OoUsIEuo7//JSbs/bJlHSZDmiVC0RLZsKnG2JhZCsQ21ULEb99qUKTJAlsTogO8OEhyX/iDjJviu3Ei1XPklyV6PmnGGKR0RwNJCazJ+bxZOecavxN4K6tVcIW0NnyY34MLeTZ2EMtL0JQK5WqZz6/ZsUsl69P5ZQFTK22wEzobTIHuEOwUIj7+YUXEPxb3CrST7BRzf2DdLswqLnf6ms/gxhvYoHGwOA9mZsU1w/XRSqlSlY58bcm1ekb3SJaMwOtgjIx/Gc9nVGZGUe0fRuGUMKerw/jULiGu1mdrWSIdFS8naHUtxlSlukW0mDo66LJDAQ07
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(6512007)(41300700001)(54906003)(9686003)(316002)(26005)(66476007)(107886003)(6666004)(6486002)(478600001)(6506007)(38100700002)(82960400001)(66556008)(86362001)(83380400001)(66946007)(110136005)(2906002)(4326008)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vyPoEsJSIBAa6PSpwPWp8ejhfOvXOfG9hQtm5l04SYA+kziRq8iTtAassS45?=
 =?us-ascii?Q?2hy9tsGktfJhpaToQ2yL6QeXA86YqlhEPQc2gnOVxGWnZJCKGCJ6UU7ZsYkn?=
 =?us-ascii?Q?SoH9+Z0IZa/tOXXNAC+3Nk3Sn2HhTeYK/7vrmd8lncEBngaHPZF2F6Xtt3Rs?=
 =?us-ascii?Q?mwaCdcG4OVlhzgu4mWNaAIrNXhE7cD55UsjZDq62c3jEkgoM1nX8f65gPz4O?=
 =?us-ascii?Q?PJqGloD9JfxR9z+6x2g+3R1V0vHK+1V4ptTg2GQpV9xSVSQ9u51w5mpqA1S3?=
 =?us-ascii?Q?I3P39Rsgbz1p9jADaJnLThul8xgdzJTgCVO9yimsTp57z92KDSUKuTsaJWrn?=
 =?us-ascii?Q?b7XB404kRYpNNLD3mAb8NxxwhY9CbB5hyi5cjNDAVckoBTbALR8bUcM+5X90?=
 =?us-ascii?Q?VY5JQV1bF8NqvQy3pEXbV/nDKGQt0c1NWMqICe89xxHwUbjS6PxC6teOTfOa?=
 =?us-ascii?Q?RVWA8qutiJnNPPEHwRATgdkeq3pKRkE+NsDWkxmtu46mGHoVQN1ig7bAjJM/?=
 =?us-ascii?Q?ZzobVIpqo6DSrN7QzcPWVbXpGfhGlb9UhhMrznRANSufGMSpxHyU0WdgJu8i?=
 =?us-ascii?Q?w8vkIswookBLeLQq+M56YnPDm92E6+HecutTkZw74z8Kx6czB/3QDE7NYz3e?=
 =?us-ascii?Q?vZLcCOS7SUo9Itv/kS8SmdqbQdC5hM/D2NKht7mThu0YlDxdpInGUkq6VYpW?=
 =?us-ascii?Q?6gnAPySFe6SEFvkU3/TlLAyfI/yilUMsGvanf27McNbt3YpAG49+IkOwj903?=
 =?us-ascii?Q?aURdhGTwiqcNFQ+t68UscIQwqXVjefFntzsaF8Ld0LfFiR4G7Jo8uF0lu0l1?=
 =?us-ascii?Q?FpdbQFuNgStKYUfvDrMyqSI7zETQCP0aRL8ljdpiEs4BH92UN7gGT2uEjX01?=
 =?us-ascii?Q?9OsB23gVKWWeXiTghGvQJu3HJC4gFigyqGB9szOi5aOeu1a7vZop+agUevMw?=
 =?us-ascii?Q?dBmJp3vvuR/6cOgTzsFHLMvaoWJ9xMwyjnpym0/vSAUq2AzE/7imCFvYXr4C?=
 =?us-ascii?Q?zQ9pU04141iZAKX0tNyz7+PNa7OZeTfcSMEtgqbOT3VePnpWtCELvnxwq2ch?=
 =?us-ascii?Q?+54mLUb3vpvwypfMFs1l5/AU3+55m0+Kl5v+3s3sof3/9CrlEeCO3mvrE4Qm?=
 =?us-ascii?Q?sQO2eUAGpPZW1WfiEn8RXiyaZFl50PmlH9q/uwM4C6iBB2TVl/WjOLyoiwz6?=
 =?us-ascii?Q?/8sJvqFhAMHmZFqYeQIWjg4HeMHNCqR0smfbcaM3B+R2WI/BFzyXj7QVwLry?=
 =?us-ascii?Q?cOJH/h3fut+CzR6bZlJq6YTnqqk8FR7vT/Az0orIqo2t7jGnU6fV4ey4guOP?=
 =?us-ascii?Q?+WlvJuYAUhcF6M85rns+MQjIr/+YmlNFT8yW+U8ZA3usGdWPLy4oPh2JN76N?=
 =?us-ascii?Q?KaiJHtKWN8ArjmPmC7hvlo2WLF2zBFpYuOmiAugC6e456jC3Bit64TGZDE1X?=
 =?us-ascii?Q?iVty437O09Fh392rZWyKsH1FIkb6GcvOR1jgIEGxjDW49KAx+87dAkkZJvrQ?=
 =?us-ascii?Q?3lIEML491ny1I181cqcDfhfBBufj0A72MtJGfTr65wrplelvqm1QxuLfb02p?=
 =?us-ascii?Q?oLdwE/haq33YGD0BtA0NqKnkbqngtObokv4Flm1Is1md897uzjy/E81sopjY?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bbe8ba-ce4f-4e69-2f88-08dbc50b5e70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 18:54:42.4233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hgg1UOmlIBxcj2XzoAb9X+LOOpba7lRY9wVy72nkiX9q7LHniS0daECPpALMUT0XmOy0PxI3lxEp+Rodjvarn5wj4hnFaIdRFQygoVwanQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7498
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

Here is the full fix, apologies for misreading your fix earlier:

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f69f6195c465..a84932ad9392 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -187,25 +187,25 @@ static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
 {
        struct cxl_dev_state *cxlds = cxlmd->cxlds;
        struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-       struct device *dev = cxlds->dev;
+       struct device *host = cxlds->dev;
        struct kernfs_node *sec;
 
        if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
                return 0;
 
-       sec = sysfs_get_dirent(dev->kobj.sd, "security");
+       sec = sysfs_get_dirent(cxlmd->dev.kobj.sd, "security");
        if (!sec) {
-               dev_err(dev, "sanitize notification setup failure\n");
+               dev_err(host, "sanitize notification setup failure\n");
                return -ENOENT;
        }
        mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
        sysfs_put(sec);
        if (!mds->security.sanitize_node) {
-               dev_err(dev, "sanitize notification setup failure\n");
+               dev_err(host, "sanitize notification setup failure\n");
                return -ENOENT;
        }
 
-       return devm_add_action_or_reset(dev, cxl_sanitize_teardown_notifier, mds);
+       return devm_add_action_or_reset(host, cxl_sanitize_teardown_notifier, mds);
 }
 
 /**

