Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA3CC7EE22
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 00:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239684AbjELAAh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 20:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239771AbjELAAR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 20:00:17 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3C14C39
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683849588; x=1715385588;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9mB2fXrUag6ABEZi62uKxPgE26iJb/Pqc6fXIKKdtA8=;
  b=AdHyCbCmgVPeBzJdl2icLoVHNLSpceEtSsmiNb47/Y7kV8Y6zLQw/mei
   xUSk21U5b0MQthMuEFawjsvKLS126II1UY5kLx9NDFTYGHPLvcIRmI5c8
   D619XUOyKISSQJPivxJ0Ut7GJY7qt+Sb5QD4F/SIydzaubAXwquCJcDpN
   8UWq92ajCj1V9XtE/oxsTerEXmMKAmyOqgBM/6m3xxZ+qV/Er8SetoLyd
   RW8ZoCnNiGyYPvEDiMd0ayAWeDxvb/o/+VY+Jc/ttOJBsvE+XOmnkNcYI
   bUEdHh/V3sgZ2nMYE77jf/AUyoztYso2IXkcf18QDsaB7lavV3VX0uaFs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="331026993"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="331026993"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 16:59:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="732806985"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="732806985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2023 16:59:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 16:59:42 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 16:59:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 16:59:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF/SkaW5517QtHRwqniHaWTop0jvy/9YkTC4BXBeHh7UVi/r2fww8XXuJCZkAm/d2REtOb1w/Dg7Do2Yp99FsByXJ7L7FFz52Sm8HWjB5VdXOQm7e4SnFIOapczXfh58EmsqA9UsU08jrxlrSb1svOvIfEjznhUkjoQPkKSVgkMEAqtkbTx9rUKm531PGLmL2O5wZr9twMf4S0jVvIfTdX9SqXohG1yisasdoa3cCcfkse1eGXjpPCl9rqBQlQNHGMZuthysjb/Ujx/8rKp4VxPXJ8ggYNHTpMqCerZ6SP6pfGlU574TUA6+jrgDMMFZXDtkNzye+8H2pCdJS8CvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mB2fXrUag6ABEZi62uKxPgE26iJb/Pqc6fXIKKdtA8=;
 b=YSr/OobHyji0Jvu+zzJJpKhQJ+W8ePpcz3126jUNBlvIKIuy2zaZjK0buUdm2W55LUgBD2vQZWAByoSZl/m1Nr3HNV/My1M8KOyPf3Bj8XULHPuBfWbz6kxHGWpiogL74ixvVpf0RR2ctINbBiGVnqJaIIkBbznH1MZYvKT5L4WM2aspk70jFdhZ6eJqAWMviJWGIQEeJ24/2OWga8/zj/3JdTEvgf/5i6ybd9bYT1e6T6SLoBPeiBBFRkIIjg0YEmKF7kHGqcX9zTSY6LNCQolC+TVTq/sGV2rlwpG3ZHkNnu8PhpNSjWkeptYyR3YvNohpIRNe9nbwOPxWAAxZkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA3PR11MB8024.namprd11.prod.outlook.com (2603:10b6:806:300::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 23:59:41 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 23:59:41 +0000
Date:   Thu, 11 May 2023 16:59:38 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: RE: [PATCH v2 2/4] cxl: add missing return to cdat read error path
Message-ID: <645d816a18c74_1e6f2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <168382784460.3510737.9571643715488757272.stgit@djiang5-mobl3>
 <168382793506.3510737.4792518576623749076.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168382793506.3510737.4792518576623749076.stgit@djiang5-mobl3>
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA3PR11MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a21f516-e9c7-48c1-6837-08db527bc8a3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDIALvaMXqqUmkHTk+Ipv/XLpOV0cIYKGlmJu26NcJypoUTq3rcaFssPIlGFvEt8Mu7BkQyIjIoFhSFzweHk8s/ukyTBuQb9shyXuDMqNizp0WhUW37XX69o3UlB5T5eKac3YXgUk8NvfW99ffpon7fNJ6eJZrK5PBgEXnnBNzyvUw4eJNtQMonP28RP3g1F5JKhMNPZzOs7CdR2EjZkMBBek55QqDeSOKn1PjsJO1oIVjxCNs+i0/vyh4eDOlZJNF/nm8+49FMqdLVjSssOElXjquxqCHxT6KgdmT7rBEbgn+baxDP3qP/t7fi7ciNBa8rEWlj/hTp+GfXu+DiRs7/TWLhZxjp4QEgCmmhQcPvJyZt+IE3SRiOafPY+YHshR2ELGOkCVyx9Jo8aeXRNKNWcHIoPctyt8gdYAIwjTLpgygbZtLE4mPtnH15zp8Catm+AP1BqakN8Fmdx/eZu9eX+SQkBd631Cxe+S39QJl/86OIgdtfOzB8dw7f95eDuXwGAgQld4uH+4qP2/tV1qI1WLogDwl2xgZf4gasQR21Aj/xjFxPapZPomy/bTb4z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(4326008)(478600001)(66556008)(316002)(66946007)(66476007)(86362001)(558084003)(186003)(83380400001)(107886003)(6506007)(26005)(9686003)(6666004)(6486002)(2906002)(41300700001)(5660300002)(6512007)(38100700002)(8676002)(8936002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?thWCbnN3bBQ2vbNY+PiJefycz1Glc/ho/dOlpmmF897kxQUSSY4IGGPwV0g7?=
 =?us-ascii?Q?M7kF+3a43lWZfYW0eLkaVFL7314+HVh+fQrRq7cW0nEYq8eWB8Klxy1S3poR?=
 =?us-ascii?Q?FdclXDpjdjpeUMsccQld+oTZKL6PgzkY+ZZbXDbLZdXsYgGoMmWhObNf71SZ?=
 =?us-ascii?Q?YXRhEqyfx0I1h5LqxPCU7RnC34fqQWzQXGQADhVuyZL016t8qWS091Aq+pFg?=
 =?us-ascii?Q?5XD8qZ8uquoAUPgZNI5eIpZ0j4bAPppJe3sTcnvv5AxSDo+w0iCDGXsef9vc?=
 =?us-ascii?Q?ElB6++VQhhcHNRH22uW1q0dwXg5RGqe1VAIcb5O8TvFsPQemBtvSwYCDNT3l?=
 =?us-ascii?Q?yPh0RoHisVmZNJY1wo7EjjRmmMg6/UeOTBtHhHOdiocroQpd4dOP3dJ01kTG?=
 =?us-ascii?Q?ccNt6pMZOOvuyiTFdKQ3wcqLEdJDZb6Hpznvtl8Cq5EfT/AbMozCtljC5XBC?=
 =?us-ascii?Q?k0cZSpFjMtmw61z3i518XCAicKbwoQsQIWAKtdXTwm23ACn7+g1ZHi/LY79u?=
 =?us-ascii?Q?XRFVZtF3Q+DfuK2w9G6jdtLjgbOQSc9nxnozKZMu28IvNSVl3QpXoNYczGck?=
 =?us-ascii?Q?dZ6ucT6kgZS+4b8+xxWv25BHsILLdaAiZ7aH6h+mkuHhNFGognV/AuRBdgsm?=
 =?us-ascii?Q?HSb4jFPJZgGIIlVMeef2fRKL2RVEFcvaEVrSXJGr9DAfNdi1OZJQtCHh7l0l?=
 =?us-ascii?Q?WoVL3zxSzIhxOmqm967+VkfygBgNf8PWTm646wWzxk70hgL99Co2p5pam6F7?=
 =?us-ascii?Q?codZwByOoFvc/GNuY8HTgUeMTCoR3eTPvSYsxy5mf/TCLGj6N4PW/9lKZAf7?=
 =?us-ascii?Q?8/BB38g9jNEtxx8ug0stx9SgvFY+Uce0GrAjafsGzfuvtxuuWHMqOinRhMw/?=
 =?us-ascii?Q?lAcrK41htAbsllwTxylzfE9lHf2pALyUkkxoayhYti/PT2T19gCZw55nN38j?=
 =?us-ascii?Q?84k54hxv4jsXe7Q1HCYZ3fagglKfDLzt0bvXd/Iz4/hjMe2IKLrR5DjcGAVF?=
 =?us-ascii?Q?rkR71uwn9lWUgSLQHckdpS4NFfEf+a1XT1lU+rjypaLBrUy2pk9gJBkDU9Ct?=
 =?us-ascii?Q?yzY6deo+KUB++lvzP4LsXPaPcaefgPLJi9fnsuVQTQ4oMi5i68L8nZzukc1d?=
 =?us-ascii?Q?AB5nBuuUYBKSKTeThVkyMfjXv0N8DqIzb4k0/0dL1NL7ffPyOEmlYskBp/KB?=
 =?us-ascii?Q?Ga72O1avEVL6OJYV0Z0ychrXytBio2VsvzVD49JWcuDjMblwnq5QfIG9av8P?=
 =?us-ascii?Q?Wx3cBoaZ0wBNWm4ymsKUcZw2SPBZKjHsoKnT+oGK2fdUvFBKPaqwoOcqKDRs?=
 =?us-ascii?Q?B+RLGUgWIa9ZNPSdLP4vLrtaNoCO8rkfEBJ+f67dhcpG14ijtb2U6R37XaQf?=
 =?us-ascii?Q?4mWw1uMcs2HjvOxA3WPzxzfITdLMKLxqxJfmuwGp5aVeqRBFXZGYfzsm05LA?=
 =?us-ascii?Q?ku9WGK4UjF81gvGb9zZnAWv3qZD+7e0h2LFQ/fbzgY14DURfJo4GK8Q4W3cQ?=
 =?us-ascii?Q?HF99jxXCFXvBRlLxKAss97wld0A1iOj1apRDiyh7wOut+SDhxf6xgmCMWavy?=
 =?us-ascii?Q?EkB8V74RadwWdhfrmK8uhBINYlJz4MWxHQyYp3UPE5Y/z3AATuqJ8mqNUjtJ?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a21f516-e9c7-48c1-6837-08db527bc8a3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 23:59:40.6692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYLsG1VnjFIDlVFz/7jeyLVYYVHt98WHWT3LiIXX3ri8a9wuOerLx9Km7gBaMAouTaB5I8cbhClK5sa7SwCAJQIuhQCGhMy6Y2PWyta7aLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8024
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Add a return to the error path when cxl_cdat_read_table() fails. Current
> code continues with the table pointer points to freed memory.

Yikes, at least the attribute is BIN_ATTR_ADMIN_RO(), but still bad.
Will mark this as an urgent fix.
