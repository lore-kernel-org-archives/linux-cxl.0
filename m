Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3428DC77B6C
	for <linux-cxl@archiver.kernel.org>; Wed,  5 Apr 2023 22:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjDEWY7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 5 Apr 2023 18:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDEWY6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 5 Apr 2023 18:24:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB0D5599
        for <linux-cxl@vger.kernel.org>; Wed,  5 Apr 2023 15:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680733497; x=1712269497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZV5rCJn4aqkw7f9mNHVFKorqVixDLskkyvBljSsRxPM=;
  b=NZ6grM6Njq8FoHdWsiLHdnQ5j8svWLQLdIrDy3Vg17xun6cIr+eE7PQr
   eUkRggPv6gQO3HQP+BEZ6x1+2Z4tdRCOWJVIzG/bHmwQnbC/bizg/zR3q
   Ib4lK1DK+nDJB1E4KIunqfLQAa+86C3NUqb4Th2yGXHx3U8u1lOrlx0VZ
   7cl4G7LH2CXHcTYsJXNR5lznGZjVCWShjHS+Hu81kZPn6exU3pNuxplc9
   p8OzmabZw6rQnoawsy2hHjuFCS6xIEWu7lbDwH3ggx+OWshm+0zuZxpz5
   eZLVODQfEr7hX4YL4sjxGur/8yhNeOMf4g2ApQlJxXJTwSXXT/akmwZhJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="340077947"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="340077947"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2023 15:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="776230786"
X-IronPort-AV: E=Sophos;i="5.98,322,1673942400"; 
   d="scan'208";a="776230786"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2023 15:24:47 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 15:24:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 5 Apr 2023 15:24:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 5 Apr 2023 15:24:47 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 5 Apr 2023 15:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeN/zY2stWfIDa//V9My/xrseSKPAtHWU+TVKJKYIPk6K/fcJzaZGQTLoIJ9TZTJlaYe8PjJQ6tupffSSmjCPzIqQiP0VTTznFAKNHm4RjS3m0w/MY7IU4PCwuWHv83dSlOIYr2AvZYcU+uBza4eQuLDSC0MFSzrVD0kLVPAbS/zvom5eQPCcMoz81TdegmW9K8DmJlRtM7XAJuzuaJ5fvICcRrQm8M2VgazDB4u/3zuyxH7NgpmrwdnB8Ta+NjeusgAc0xSmfyJDn562MUGxTp04q39lD+m3wY4/cEuUIeouO2RuKtgcWNTbctJ5mqXBqcrWnSIHbPe8bq6DD6mtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRd5QMZIjwM2JQ7YUiyaJ55umVJNNpqjfcpewDbuNok=;
 b=fGWC3KqOnsX8N3PmQPBNs1wg6H+19qFfxchA+cAHS6IwlrkTMSehMApYz4c0Ok9BGTNTpaa7GNfNdik9bYe/tezolasXbxq8NRREV5oBMtTZjd1JkSzcRtv+UP5vqG387CHNbiJpEOb7/3VjLYhXImTWw+MHCBsMNjebrOADVNEW1arcLl80A5DC33xd1SuHHkjzAibUH1Q/HsdOTP6Gwdr3MAAHWJHlZ2lBRVvcN30xBCKqISaWXXVqH39UhNsk0t9Etjo4EIseyFmniGBaD4Tb6m6EvicufjzpjoFFzoUY2Ow6u4HdbPHrnEvAdSJoXKilhLKE3vwN7VcG8z4C/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6447.namprd11.prod.outlook.com (2603:10b6:8:c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 5 Apr
 2023 22:24:44 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Wed, 5 Apr 2023
 22:24:44 +0000
Date:   Wed, 5 Apr 2023 15:24:41 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <jonathan.cameron@huawei.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/7] cxl/mem: Support Sanitation
Message-ID: <642df529cffcb_21a8294ed@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-5-dave@stgolabs.net>
 <6422888b688fd_21a8294a3@dwillia2-xfh.jf.intel.com.notmuch>
 <20230405210622.cxujzoaceuxpfopm@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230405210622.cxujzoaceuxpfopm@offworld>
X-ClientProxiedBy: SJ0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::34) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: cedfc137-8247-4f23-cd2c-08db36248e6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199021)(38100700002)(8936002)(26005)(186003)(6486002)(9686003)(6666004)(5660300002)(2906002)(6506007)(6512007)(66476007)(478600001)(66556008)(66946007)(83380400001)(82960400001)(4326008)(8676002)(316002)(110136005)(86362001)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-CrossTenant-Network-Message-Id: cedfc137-8247-4f23-cd2c-08db36248e6e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 22:24:44.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvo9+r4DvLeOmjurkPOjegjg0Phl77zjGmEV/MkxHK3J24ix6skm8NtOKYIn+mLderVcK5gh2Qmf8ORqmuIwggupx5V3/Kx21lAo5ZLUbpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6447
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Mon, 27 Mar 2023, Dan Williams wrote:
> 
> >Per the feedback on 1 this changes to be a facility that returns
> >immediately and signals completion via sysfs_notify_dirent() because if
> >it takes seconds and is hardware uninterruptible then that warrants
> >userspace being able to poll for completion if it wants.
> 
> Perhaps I'm missing something here, but how can we signal completion
> for sanitation if we return immediately (after timing out) and loose
> context of the background command? Or are you referring to use the
> Background Operation Status command (0002h), which afaict would be
> the only way to do this, as nvdimm's overwrite_query. But as we've
> discussed in the past, this also means that another bg command could
> occur in between when the command finished and the query is done.

The observation is that sanitation is special compared to other
background commands. It's so special that it gets to skip the normal
rules that background commands are parceled into tiny pieces to prevent
monopolization of the background command slot. Sanitization monopolizes
the device by definition.

Given that sanitation is going to take on the order of seconds, don't
trap the submitter in uninterruptible sleep. Instead, put the mailbox
into "santizing" mode, and return immediately after sanitation is
started.

In "sanitizing" mode. New background command submissions fail
immediately with EBUSY (as opposed to queuing because sanitization
destoys the device's context). The end of sanitization mode occurs when
the completion interrupt fires, or a kernel polling thread notices the
completion (in case the device does not implement background command
completion interrupts). When that happens the mailbox exits "sanitizing"
mode and reflects the completion status in the sysfs file that was used
trigger sanitization. When that state changes sysfs_notify_dirent()
tells userspace that the sysfs status has changed in case userspace
actually wanted to go to sleep while awaiting the completion rather than
live polling (but that sleep is interruptible and resumable if userspace
wants).

This is similar to what happens with address range scrubs in the ACPI
NFIT driver. See drivers/acpi/nfit/core.c::notify_ars_done().

Think of this like O_ASYNC semantics for sysfs files that trigger long
running operations.
