Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FCEC7EE2D
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 21:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbjEVVVu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 17:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233898AbjEVVVs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 17:21:48 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02119D
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 14:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684790507; x=1716326507;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SgpJKbF+4mYGiDCiPYAURnL20K+frgy+iOfAqL9cXcg=;
  b=Hxhw6zVcd0N+uxRlu9iQyyxcKLOqtKDjyVKKGMWlnVkN9tne72Kt16ly
   X8UgOVZY9cwy3HO6q6wekYPdnEmvZv2UMITQVmKA3wL1LvE79VZX9xE3w
   f9OtafxfmADlYvi1Nj+Gq0o7eSi7H5jix82hD5K8tcqpnuBQdFGKnKvhG
   y7Sp2Z3Z3uCZB5vQu7sRRjb2JlUPhxW9fznajKd6a+wntcBC4ZiIjGLnu
   utLiVZNI9xyuC4ubwcJgc5HO+YOBlASDpcR1fUFOPFXrGZFnWl/11NnA9
   9GIM/c5NMBZ9yv1tLFI23Pf2a5k6Yqkv2UWnhyz95zZJ1fcKNdxfP4Dre
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="439400127"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="439400127"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 14:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="768695090"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400"; 
   d="scan'208";a="768695090"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 22 May 2023 14:21:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 22 May 2023 14:21:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 22 May 2023 14:21:46 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 22 May 2023 14:21:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+jIooc/zXhEnzaN8dFhPQIjI0REHWvGXAg/quCZ2cOQcxbpCfk2odKFJN+WAIkng0LGeJSM+Y2j0ZRyjnlwMZ/0/xjE7c0ud/QoEFCVa4FZJOeDp4uixNPwDNFLwNeKBkEtRdeewYDxH1BPjgmiOc9IrzVULqD2M71UftAZBF5/AivGJ4ASjzMSU0UpADhJPMP4Pxx/dxceXm5AfMqKNrWvo66+G+zhOT/vlFyEA3hmgbNoMz9p++EqqtS5o4VBlaVVR11hjIkS04JETBIaqlBBi01T34fdDi7H+ADzlFzmS/E98wGE4MICC2lQbgEtkDDw2I4FmZBjIltp2hnyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kw7dupH7OXy2b05u2T2rhpw+ZVhOjkrt8a11bZpXiA=;
 b=HgiobF/Y128YM5x66iXSUN/+Roop20u65mjcGRAqJGplQVTL0GJtxpsMIJN3oM4qR9K63NODN4Oue/SL1tuBhBApDTFuCM6v85MQDiN4+QNR0rS/blOFTY31gnrB3HGpgve7C5oc7nPPAnm432x+QyopxYQoD31CmwV3laraQ0qWcwlMmebKEYgI+gKcvI1j+kqcmF+K82HCzmueR2b6JdbptwcT/IRWqfB92hfd27lHRIdwgW7B0QhkfnK8y3ecH9IgCwru0aY1o/xVHQGA4robGzCrdS83q4MEDbm9bNAgV9vCyMG/EzHdyFGNZr3rK8ocKc9ohg539QNtCpqhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 21:21:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 21:21:45 +0000
Date:   Mon, 22 May 2023 14:21:42 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <646bdce675b59_35a4829434@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
 <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
 <6468027e5d15b_682c12945b@dwillia2-xfh.jf.intel.com.notmuch>
 <64jusopypczmfmkeg5ulzw6gwbfv4mdnk2jilmja7iyr5dsukc@vkpwdjsjsbk5>
 <646bb221db164_33fb3294b3@dwillia2-xfh.jf.intel.com.notmuch>
 <ps5l5kclllyhjfaelf6p7cl4vsq6v3lp5uxoqt6u5m4ha7adw5@6q4gjq7hlxpp>
 <646bcda53c22c_33fb3294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <dbz7qo7rsbyc7r4vtcwc5lkpzpy2uz3q3cfd7qekhghp3amn3x@264xhf4swkda>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dbz7qo7rsbyc7r4vtcwc5lkpzpy2uz3q3cfd7qekhghp3amn3x@264xhf4swkda>
X-ClientProxiedBy: SJ0PR03CA0140.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dee6b37-174e-406e-40ad-08db5b0a8b2a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KoCMhEjUDrDen07L6zeSXX9Hstu9uS7JMDOUUPNlwb5f0hHh75wIBjb2itup8F7VJaa0T2r/4jsj26O0XzufSJjI45mwjfiUW68HxXmd7N4Le6eaw+C/cEugOGKQg949tzgNj3ELuNd1aU06vjn6qA12Pax5ylYyqSccg+IX9qYD4vGkqLHvyMDya2K9J0IX7NFSQZYhOjJZl//ANhxwvk97mDLJq0uMXTZAaDyK1PO1lkfszacsFTYtcic1VkjwTCZ0+THi2OsFipepPVg+340iO5rXjM0n4ZuDHRQQ4/ySKQys5AiTRXxF6Oug4aXD/i7nGfrny6KXp5SUgaYMQu01CXZuAs/Xv/zCWhsyorzDLT/a5ejn5w3dSapLeZfuaZuiXh+H9KrSfxo5FZR0k888Ai42IG/qrws4FrOM1i4LfPm3MPBBJKkjl25QngJE63JMYIFB4ACQwIqgeON2wTzlq3ZXhiIe3eub7OtL6HDKh22iotS3DICHs3pb+OcGNeszitBE8/9jS+wRMeteu31xJM0+AZJsAM7qGRqUpLp2oAnfRdEYtN0BLGd4qv0J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(8936002)(8676002)(5660300002)(83380400001)(6506007)(186003)(26005)(6512007)(86362001)(82960400001)(9686003)(38100700002)(41300700001)(6486002)(6666004)(478600001)(66476007)(4326008)(66556008)(66946007)(316002)(110136005)(2906002)(66899021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Hr1xodcX7u93Ihi6bgRyGmakzC56fkeKK0ymTEdFFT9g3LbyNVc5dV1CJvF?=
 =?us-ascii?Q?Xw/EW0C3BryAb6JSrIyEjvZ1R2A+yM/M5pBamYZPEdSnYfJBbR2Ct3WedX2z?=
 =?us-ascii?Q?hV0E6GQDQB+7dk/0Jrht/NEufdq9mVqt4B4v4Iv1XZBZ7O4xITv5SN3i3pvD?=
 =?us-ascii?Q?0vG18NexBAqITM9J6+enMSJdexl9WwJasvl2mLZW7urKuAESrbWVN7vsGvgG?=
 =?us-ascii?Q?7kdSzV4RsW+Bk18QHVPrcn86bNR2Y8dRsf3r6jODZXQ2QPP4spSwzy1bCZiY?=
 =?us-ascii?Q?TmYlw6Itst3dUzKtOBlAsr/nCV0hJq7KNPgA0ZgeTTBP3EyHtYYGDlMrFVic?=
 =?us-ascii?Q?/oPenivemCwGBW7AlPbz/KUnICBwU9tNGTMQjrcLruyOa3uf155bMfIzI2zz?=
 =?us-ascii?Q?YYhHxqg8jNW/I//DkzoEpgQhiQ819uJjqvbER3Lm+vHSfX2bHaPufEIa6PE9?=
 =?us-ascii?Q?mAKg76dpXoJOzNBo+Dt86VKJJg39YQ+0TGE34axXMWkonnoeCnlqhALdzlkm?=
 =?us-ascii?Q?l6qfDjnZfjiOjz8DzupywWBJ0y7cJnBVaCWRDD0PssiLQNZl/Hf36gGIORdD?=
 =?us-ascii?Q?NygcQ5u6uGlLNpteiR10vYIHG4tgIaXM+zJDKnDdy9+G8XGMu2V2i+u0jPcx?=
 =?us-ascii?Q?Kw022J249M+hXnZhJWjIuLyHh0y2ZCW+QxYhoVombZtVFKCifhLAr96QrV3L?=
 =?us-ascii?Q?Vu0dd2k5yrbPjGNFN4uuoiCjaJgRTiedvlzNWQJoO++yb5NMN21yQsI47133?=
 =?us-ascii?Q?49DDJwqoaGD6M58Cbd/hJvMzv5YghyasfrZCfxVdfy8Af0wLzNNkQ8uj/zzB?=
 =?us-ascii?Q?y26th0JkqrqrgoxMtrNK3avrxSaDhdsYMGtMA503iTvrRDPFK1zeajzFRiyV?=
 =?us-ascii?Q?89Slq847YhHVMGCBycds2OItfBm1tPs3Zfdhllu/0i55sE64HxJB5fKTrVVc?=
 =?us-ascii?Q?ToXXZM55q+HCwwQJOObgquvxcjx7gDWaGo/H6QZLZZTm9mNsivuhvpYwYZnp?=
 =?us-ascii?Q?C2JKXJNUNwafQMR3hhEoDxxMumqY1Ol+6cbe+hHCisRmdhIgYA49DcvzRiAY?=
 =?us-ascii?Q?hh9sTr5z8Uc2IFTFlK9AsJTgx/oCV1bkwaGEDEqaryauPYPiBpCU3OYwn+TP?=
 =?us-ascii?Q?kGyPXx5EUuXJ5S6DCQAzWsIa8duXxlsyG5gz8+fUabnGyzL3oDH7ABlViRim?=
 =?us-ascii?Q?DXzNgW64xPr17+Bkk06tpDBSvqoeNcYMB10KfH69UY0/9JF+ePE926VdynvC?=
 =?us-ascii?Q?OPmJwpOBd4kLzQCdDWhCcBkl7M5YI2IGr3HsxzF2zmsGlY/R5+THv6aN3zjB?=
 =?us-ascii?Q?scdw6lgaArPWzDTNkXP04m68Tyu1BOQUpDC2rednSqPgFEc/AdrMWRuNT31h?=
 =?us-ascii?Q?Fzc64JgSXUbXixW5xVExZ5V6xunJBvzL76rtL+spuDidvwyvRSsk/lEz4uxt?=
 =?us-ascii?Q?UmjRXFYUw2zJlldTSNbSsBHGjNk+XXWhXTXxGjvDZYJ37Ctulkuhlgiuapn0?=
 =?us-ascii?Q?DJGfwtLc4XFpvZPCMcc/aQ3zmgNur1x6TXPHmQqNG/xCyaBj7ZqDNZ1dRHK8?=
 =?us-ascii?Q?Z81mly/uIopV3nD3myohEl7eCKUHNDqSfn58kGg5e2qrfLsXWmORqOZxSNT2?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dee6b37-174e-406e-40ad-08db5b0a8b2a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 21:21:44.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iLLWvNrWyce0eeZ6Ed6wZ9ZJNA40FbUoGp1mpXGoX5c62nkK2m+MwS1Y9p+wMHL+qBZqmE5J6GDM7chsaujrHBV08Vx5p0xwvaB04ME3Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8313
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Mon, 22 May 2023, Dan Williams wrote:
> 
> >Davidlohr Bueso wrote:
> >> It at least removes one point of potential disambiguity. This out of sync
> >> issue with timeouts was one of the reasons I originally proposed dealing
> >> with all bg commands asynchronously (which doesn't prevent users from still
> >> time-slicing). This approach is supposed to make the code simpler, but leaves
> >> this mess. Currently we state:
> >>
> >>	 * In the event of timeout, the mailbox state is
> >>	 * indeterminate until the next successful command submission and the
> >>	 * driver can get back in sync with the hardware state.
> >
> >Right, but my struggle is how to explain to userspace what to do next.
> >Does userspace keep submitting until it gets a successful acceptance?
> 
> Yes. It would be the users' responsibility to deal with timeouts.
> 
> >How does userspace know that its failure is induced by background
> >command collision?
> 
> Knowing about the apriori timeout, would the user care?

It's not just timeouts its also SIGTERM. If the user is allowed to say
"I do not care about the previous completion" then the driver should have
some way to get back in sync. Either the next submission needs to wait,
or there needs to be a facility to flush previous commands.

> >That's why I think it is ok to block and wait on the previous background
> >command completion when the next command is submitted. That seems to satisfy
> >least surprise. The submitter asked for the last command to end in
> >failure and is asking for the next one to queue up and complete.
> >
> >I think this means that cxl_mbox_background_complete() needs to be called
> >before every submission and needs to check for "background operation"
> >(mailbox status bit0) being cleared to manage potential collisions.
> 
> All this really defeats the "simpler" angle. Without accepting that it's
> the user who needs to resubmit until in sync, it seems doing synchronously
> is sw shooting itself in the foot.

Make it as simple as possible, but no simpler. The driver saying "you
are on your own after first cancellation or timeout" is too simple.
Especially when the driver designed with an eye towards not allowing
long running background commands be submitted (outside of the special
sanitization consideration).

So the choices are either allow the background command wait to be
interruptible and then do an implied sync on the next submission, or
make it uninterruptible where timeouts are either a real device problem
or a driver issue that needs to reduce the size of the background
operation to fit the timeout.

This middle ground of allowing SIGTERM and then userspace is on its own
to repair the connection violates least surprise.
