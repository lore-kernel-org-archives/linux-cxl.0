Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F72C54E94
	for <linux-cxl@archiver.kernel.org>; Wed, 25 Jan 2023 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbjAYWom (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 25 Jan 2023 17:44:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjAYWol (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 25 Jan 2023 17:44:41 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BBD2B619
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674686680; x=1706222680;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZA6eKwVHoqnG6PhQ39SELW9EbmW95ltYPGZl/lsd3S8=;
  b=ChK6qhJgVeuApRxbZ5XSO5tKvvcXzqCfV5zfyRCx+uBtYTupc6GxlZux
   KJPJoLSNEsnpEBBdAXqcjUdnARa+vo9/mifEp5/yX8H2OdJ3J3oO2LJ2M
   o4LkFPDH2S8woBUvi+puKT2fa4E23JvfjJHWijw9JaqGx5iyfuseJ1DLw
   3adUtIkXx1QzGrTyXqicDEdpUDTtA0Kifc0eZ+P7+C3hluEFyoOSlZJea
   1d4wwrYfmPOPkTu7P1kihv8GLyn/CH68rJ9vrNnnhLGp/E5wtZEc5gMf8
   nGLIUQOeXkCMg11z+6rW/ZZ5zUnHvePYofC9mELENLyjffccbCjB0vwg6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="306359705"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="306359705"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 14:44:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="694899243"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="694899243"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 25 Jan 2023 14:44:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 14:44:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 14:44:25 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 14:44:25 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 14:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmuV8SLt47xXVkvkw8U9A8SOhwOTncSBmTTZPoK/+Lj+WmiWlPfOFkfZXnQRfnZYKdTuXQOoMA4rskkiv6c0sW5qAjCXM0aFAr9P+/mIrEw3WEFYtV4CetjlK7P7fAkDrGEjEfW0/uKzfp/lNTdAOdRdLthiTXegKrnf8lOopNHf+unTOy4LiunhOJVORfb63LWUyMruviv10bB0+W7ZWf6/FNai3ak6pK3wTAwYGvoWh1gZ/GJ2sAVv/woQRko0yteqvzbyomuOmJyq5voi74xfrX0eLmNEgiWeB4usPxHvVQ3kpyW8w+dcSsRBjddAbwVCpLUO1uVryeG2//fnIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2DAzOutw+azm1PNzVz1HUs4cLo2CCHpO44M4enUsNU=;
 b=C+it2TEn9w9y/ReKuwVXA8kZePd1SKsRKtpPoNe72067vjKWGl58SewlxKEBNkgN4+0XsH1KekpuI/FcFQYIt4Al3mciis2o2aOY86xwNA3hHt2y2onI6zjoynGA111WJQCjVYKm8HgfX4jRM2h8mVdkQOnyNv7tSE95+oyxQCck1FMr6towhPdABP4727c8OwZQke+Pzj9Lxh0bjBOJzYObB16j4L0g8M0FHDEN+tHNSBU18vJpkUK658YDj0i7c5PVmrFwpub0OOS+jpVwkBnWNUgIDIocOkp/H8unwjYrqHgZwrcPQ2lDqaDI/c4tAB95VFo4NnOwJOi/zHbh+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5637.namprd11.prod.outlook.com (2603:10b6:8:33::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.33; Wed, 25 Jan 2023 22:44:23 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6002.033; Wed, 25 Jan 2023
 22:44:23 +0000
Date:   Wed, 25 Jan 2023 14:44:19 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Clarify when a cxld->commit() callback
 is mandatory
Message-ID: <63d1b0c386fd7_3a36e529418@dwillia2-xfh.jf.intel.com.notmuch>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124081824.1626103.1555704405392757219.stgit@dwillia2-xfh.jf.intel.com>
 <20230113112418.0000060b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230113112418.0000060b@Huawei.com>
X-ClientProxiedBy: MW4PR03CA0324.namprd03.prod.outlook.com
 (2603:10b6:303:dd::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: c541ab79-be5f-4fe9-8a58-08daff25b431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NsBzUmxj3ufqg4O+WBKccdm24S1NKoJrTxS7nTuMjjjLTSl0LeNI5Dv6I1EbzkZmSMUbj+48unsuZ/PmtgUj4zX9wgYsVVSOT0Y0m0pF0K21UTHHkBj9lg8L58btrIIYf28Sjp1EQhAI+mwQ2r6ObiFRvtfNZasUks5Gki+bs7SMzfT8qgkzuxdyXe+D3L4YJw7xtKUvSm83jiI4yqVEBvIE8CvrLMb2T0WldSe3CEBih4Kl4MSPVqJ6o6uk7Db6hw2JHrwDLKyIgeauZ1QTR5qPJV8ik2T6ZTONdDV0PKFSTC8AKMU2I71U3cfYFYM7gvkqDcBzBd1bbwAzgAT2lYO0pwERp8cRKXBoQJkgzBgOkJRmk77H7uozaeXsQErjIMBAwn0kDossTThqsrO7Q5A+apBz2ArFiVMa31n6ipKy0+2yy4CsJtHAN666V/lerhGzAIwfsdvO8l4+xAwhCLCg/6+eHSelpZHgsXTjjsD4dmUKYw9t4xlQxBNPr+zXPvb3Qgy3mA/mUQom9uEuaMEjTv/q0a7qOoe9KZPkuhPM4W5VShDKiI2cgIQD9kpzz6aYLWqN4pB6SO2qwg6qUhVGHu8Ygz+6oJXSdEgeH7OmkT9skkim/lHixfigH/Z7xr/1N5HvJazWlG6NgHcIzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(136003)(366004)(376002)(396003)(346002)(451199018)(66476007)(66946007)(478600001)(86362001)(6486002)(82960400001)(6512007)(6506007)(38100700002)(110136005)(186003)(4326008)(9686003)(26005)(316002)(6666004)(8676002)(8936002)(5660300002)(66556008)(2906002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fqaxpMezrcuBOV8ZuAf+JxlQ8/IGy8mYU9UUraBJfZe79f/7OVfX6Cpz4UjN?=
 =?us-ascii?Q?ci2/4BZuKcTEbmEu7R8ue2ioBbP9KYr3NbP1VGPL+d+fMngiKYq7/Q2UKv9H?=
 =?us-ascii?Q?gZJJ+NXb7RuHfs5DvUwX4ztfTby8m8cK/AbzB7i7jCyO7EvNkWtW1l/27La6?=
 =?us-ascii?Q?eXKTU0nsEzCFg9pdBAhmH2VNFWOlASC3wytYjZQ2smCbb4c5maPIK42Z8ql+?=
 =?us-ascii?Q?dgU2gWCIH53FHu9jztU6kwFIIYUlweQy2LEBSc+0mEqIr07q3YbfYr6y28m9?=
 =?us-ascii?Q?1pKY1VvU/bRncXu6Qby7db7fZCJkMeGy6xpt0UjGQSMZ4YOa3h/IFScdNeih?=
 =?us-ascii?Q?9P7kg+5xqBQD2syEzgB2SSA2ED4QSdIBWoLeTaHZzobUqx+lm9RsZQV2u1I9?=
 =?us-ascii?Q?7LgC/sLYmgoGYoZWrt8YBOq6XiLIekzlGlVOCrB5zs50CqHsCQM+SWbKINj+?=
 =?us-ascii?Q?f8WEAI4JsVONxG0PcUR6TK8i5YSPidOPCUwr/tTiLp3nUWJa1PdkAWdl7GG9?=
 =?us-ascii?Q?lqSx8tHDkoRFho0nSMC6yQJqfblRgAxfbSFmqspB5ocQOuJ7RocWSacmsNrd?=
 =?us-ascii?Q?QrpY3j7ZwvLEfLRHwDIi1xOdVKwZf4FN/TRcY5Hox5JCX8gfn5q2JLL3OiGJ?=
 =?us-ascii?Q?eGxLaWJWz3INQ8PkWvXeXYHS6ZxHwMcpXmoWHShOBF5cp8PnDwwrmsfOqeOU?=
 =?us-ascii?Q?G+RWGIruVrCJ4Tli0xjLkH/rFyZkJuaI7gJDpE7XrZgqJumPSN232MBswT1F?=
 =?us-ascii?Q?B0x9p1gk8lp67JLE3stUcViNT32F4zPU4/llHd09yWdkbQ6QLl14zDo7zmsk?=
 =?us-ascii?Q?/AZ974R3ywj283ocOoz3S2KeQujyecc+wqA9xm+dVTxJ9dvdqORsnDeITQxe?=
 =?us-ascii?Q?BtercDkeK5Kskv/6Zy1/VOyLM9vWHYuFbNNkreOWzO6OIO7oMVvPjzCPMGuP?=
 =?us-ascii?Q?QlG146NdrlAwdsWhIccgbbF4u1Z+JbDBh3/s9TUyL4qBNjz2vWEPsR3EB4Ym?=
 =?us-ascii?Q?bYRDV1Gqpp9DzYUDFZyPT/5K0Io9G9CNvEMJ6Y0/IIBDeWvPTVbdJNN/X1xm?=
 =?us-ascii?Q?BenW1bnzjMWnAxKZuOLoM6eyGiiQdF82EAq2/j3/8gpbncO8GmPoS+objJJi?=
 =?us-ascii?Q?H2kJMdUr7fm7ZHhmfTrcBNeF7/ZRk2OfWEjz8UA1msI3aRI66EAwjgcDz5Nd?=
 =?us-ascii?Q?8ejWYs/qlNQTuNoG6aXVLdbz1Hiw/3Cw08fT/U49UvCDmFy6vMztPBMoOrcF?=
 =?us-ascii?Q?zj1yxs7XIVMB4KmlkL8ZDEE2+ghaFxSUUYKrVkv9SzpYK7714UNt3qKJqQJb?=
 =?us-ascii?Q?LglnphA+SodK+1DY4rsrOVfU01NYZOhIgaFdYIUqUyvncSrfZ1W1z8+TVFon?=
 =?us-ascii?Q?MV0a7J4oLkNNucO0yXH8e4aUYuvkY46Xe2FZF0YTXUqmzYC3CMASpJQ+xsx2?=
 =?us-ascii?Q?miZr5INEK2osodVY6IGmgd1syotMX3TK8XHYXyCBghK05667c4aSK0qs2pDQ?=
 =?us-ascii?Q?TlTnj/cl0zyTNHIz+aIYQLAE5JxH0L2piYY88T7pXqVgsu7Ax4Vsn0D2XZe8?=
 =?us-ascii?Q?vdg1wUmBNDdj5Y6FobcFxyiQTrJWgaHEQz4s2KROUgIj6RMr2kxRH3Y4rLOD?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c541ab79-be5f-4fe9-8a58-08daff25b431
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2023 22:44:23.0083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYPT9on9leOM/Tg4fnzoxRPNYGunSodC2R5VQZ18CljsYeZDU09GuPgweIc4218L5/epkOVlrfGE8yILVvqCm+ApaUpD7KfnOn+DrLKCiKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5637
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Fri, 16 Dec 2022 17:33:38 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Both cxl_switch_decoders() and cxl_endpoint_decoders() are considered by
> > cxl_region_decode_commit(). Flag cases where cxl_switch_decoders with
> > multiple targets, or cxl_endpoint_decoders do not have a commit callback
> > set. The switch case is unlikely to happen since switches are only
> > enumerated by the CXL core, but the endpoint case may support decoders
> > defined by drivers outside of drivers/cxl, like accerator drivers.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Seems reasonable though (just for consistency with earlier discussions)
> I don't like assumption that nr->targets is the right thing to decide on.
> It's fine to have decoders in single target case and if we do
> they should be committed / not registered as pass through decoders etc.

Thanks, yes, I can see there being cases where a decoder only has 1
target, but needs to be committed anyway just to pass the assigned HPA
through. For this patch that missed consideration it just leads to a
false negative report on a kernel bug failing to install a ->commit()
callback for such a decoder.

> Hmm. I've never tested the single downstream CXL switch port case.
> Similar to HB in that case HDM decoders are optional. I've no idea
> what we do about that corner currently.  One to add to my tests ;)

Yes, and certainly a heads up for anyone in the industry who might be
thinking of buliding such a device.

> Anyhow, this is fine
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks!
