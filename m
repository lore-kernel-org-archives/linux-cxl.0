Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5B7C76195
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Mar 2023 01:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjC1BPW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1BPV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Mar 2023 21:15:21 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F4A1997
        for <linux-cxl@vger.kernel.org>; Mon, 27 Mar 2023 18:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679966118; x=1711502118;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dzuSgux1M8Z/fYkLE9V0+hs8Xdr8Jj4ZaZsUtY4LVoA=;
  b=L0IDL7hGqSnuY/cbdqmuzdO5hGlkK/NSxn0QI5pgIleBexILKd8BEWnJ
   PMlmYs8Hd5n8p2fm9tUV+ms/uvx3QgyCplFhQQelUhJycddEHtmlUbm9T
   QqX+68k6HAabs4CdGcm1/VYTJ0zScvYKyx3dvkvfsXOBZQAnOiXxe0vhJ
   NZnrPt+xcUorOvY/MJnghV9BuBS86GIWglarKp1HH6M7lLEnUob9wBqAd
   rMEo9l10Q+r5bPGi3KkBKvpN29aFAeJaaT8g00XxeGq0urxOwKtIgE7sC
   Fa1J9IR7fCdHzaIlHZzZAskBDNwzkAowYdum+qMbMaATmmBzxeuEVM+Pe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="426699515"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="426699515"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 18:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="794587697"
X-IronPort-AV: E=Sophos;i="5.98,295,1673942400"; 
   d="scan'208";a="794587697"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 27 Mar 2023 18:15:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 18:15:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 27 Mar 2023 18:15:11 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 27 Mar 2023 18:15:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGXJKpPUEYn1ro7baSE4Ar7wGmtMsC/HDbsmOEy+/05qxZCbCpCqkKDOtT1y8FvwaK7AanGox8aTjhIWtQTXxCzPKwYqLDdfcza6UfJiOPITDZOxQMVGNEwDt4PbhO2qczQ/M3ZtK/AFmkcYLo83LMrz8G3mYub9JwCYd8NEl2PlWWcoGwkpcBlrMcVBznIGk4fTL31x4a+Wi8YApFSB6PT6oPPTpgxpwSZ6TGpM0PkKn28GqXap1wxnZwNVCjSAdVSmaEPIdYGiJ8qfeHX2UIakMc46pl9KPM97/Q6gP3nWIK8RN1G1jL/2NUeQrZ5GMCwceNxfdIOfkeLZj6+zwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wbsfNGjiHXND4vFUh7idGcHKTDmJOp9WF/OTF8QoBA=;
 b=Oi3R2b2gtkCh/s33Puq2TMuxZBCLy+QyJhwVyRnAi6YsSumgIRIGEPUdSLp6r8cnV4gJD25UWvXKNUns6FCvB/dNx1o6iM3uIz3OQApn+YqEUlBSVv4W+7v4IvixL1+i1MYjrgm+5K709P77w37GP683u6xgMjeDy6Qhuks4hbtoh8AmebCLh7C4j8dD7rb+so/qOM2E0gxfw9qZlrlm4GXnzgyQUaETdHvRA11t96JdyCSCDiE7nPwTLeeKhdWlrNAcxxgR12swBhijukwAWQxFHctJTMrc7OkVTvjzUaoDUjuUAk+MNWDEP8LSvTAJzIFrHgU/7Uytbr8KkmHmCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA0PR11MB4558.namprd11.prod.outlook.com (2603:10b6:806:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 01:15:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Tue, 28 Mar 2023
 01:15:09 +0000
Date:   Mon, 27 Mar 2023 18:15:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
CC:     <dan.j.williams@intel.com>, <jonathan.cameron@huawei.com>,
        <ira.weiny@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/7] cxl/region: Add cxl_memdev_active_region()
Message-ID: <64223f9ae65fe_21a8294a0@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-4-dave@stgolabs.net>
 <Y/wno8C4bK3XNoUD@aschofie-mobl2>
 <20230228202623.ceytv4ecryxcloxc@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230228202623.ceytv4ecryxcloxc@offworld>
X-ClientProxiedBy: SJ0P220CA0007.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA0PR11MB4558:EE_
X-MS-Office365-Filtering-Correlation-Id: c7b0f2bf-eeee-4d48-57c7-08db2f29df50
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Njyvl6QTfm0meBFkdSCbJVSAnlNwj6P1FI1dlGQvEqbOv6ROjiwhxZKlkabqn4sqqoghy/eLOQMebqLXv4tI11Axiz9QNr+kZ5Z4A9dKgO3kFYxDP8vEjD5rp+oU7r84hNVtwa3t20pUPGtuzeZZBT44J5gSyz2+yoz/6Jz1bXtcxMOfFeuLmWxsXThgP04cHTriVQVp/I8uqfJZ88WYcPdgNSV3vuHmt4GT6GRfJq/TPRsEqsY+UzruJ/HGcS43a4nIqby4WJAtmGRwjakDqnHgbFlutYOs3DueEPbAOnMWYMG2+298FfwQ020Qoc/PKSoXUKSdePtcJgtoKWlh0vQXiUfgLVyuHAFOiHTcapP7dN+I3qNDDahk5iFVIqk4PRz7VRCVuLUtVuFJEH0OIZ7ND94Z3+cPUWUrwGqp1ePNMI9FOGEeeqfqrQekYBU6D2kzSVEmz+c7OAfjTce0DkTYFWi0pGIz/4Z1GgOqJjHIFFXpgZFDfcY0FMx/jfHjknLQyHmxPcrMWsFG7tY91rIZxmyYKQslcCZM/KkYxZIPFeCW4lM5pMCWnsot2Ot+Zl2sBufr4CCRRr42HuHZ+HYgZNEfaKxvxlZ4MuyL42o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(396003)(376002)(136003)(451199021)(41300700001)(86362001)(5660300002)(38100700002)(8936002)(6486002)(82960400001)(6636002)(478600001)(8676002)(66946007)(66556008)(4326008)(2906002)(66476007)(6512007)(4744005)(6666004)(6506007)(9686003)(316002)(186003)(26005)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OigLXLqQqH5elFL3Ply4zmtdsXs8pR6gS0VHq+f4RsisPBJk/88HcNa1GyxO?=
 =?us-ascii?Q?a7IsWe4iz+EqS1RsRy1YMjDFE5z5Hj5lFmY0gzkWsZBLZ142IPxGl7WWLEzH?=
 =?us-ascii?Q?zcOgYkfziEQduGokX1yH6Ieu/TxfFT9nUdT8WFaO2fEoe0hEitsvU+IWxWJp?=
 =?us-ascii?Q?AQ2l3QnzB2q/ItRDELxoVA2iVxe27O5AtqhwzqJ4xohj7PMgrIHzbKprACa7?=
 =?us-ascii?Q?vePt+tiwJs4MQQKqjSls/GyifJJeeb5puyr/9NUzbWddGn2CBWeIzt03m+Az?=
 =?us-ascii?Q?x53d+JioABMxjdI3f192twamb2G5BcMVRj2J6rBBVQGkDNoOQ7YjOsSrsC1M?=
 =?us-ascii?Q?UZOimOPYuS/0D0rcJZ34hcCp5m65l+II/CBERFiMWMiCfLCE+5pd/O4R+pQI?=
 =?us-ascii?Q?tKrhzLc4QCLC0P9YP6SfktwZhkqgn6/iQVGmKbgA4WpV30banzeJsOzE80PO?=
 =?us-ascii?Q?/OdObBcAB1XGWPNdTs6PN5CJLG8wEn6jbvQ/EtUcKiXkIYLJ0K94QsS05iOG?=
 =?us-ascii?Q?LP+wOku+jwHvSlPPfjfwLGCOvDixTn6RnItjjog++XNLDATa2ZFSANuZJvBg?=
 =?us-ascii?Q?sZf310afr2zCF1xLY0ACz3iEEzERg1n2bnVdq1fh+DzZA8LUoLljRr6a81wR?=
 =?us-ascii?Q?MJSbVi1rH5KLkU9jBExwWQhF1HxilbLN63SQSPZV1cDXzmEO/TKLkIDGjXWq?=
 =?us-ascii?Q?ucHQB3w93w8zkt4hzL83n1L8ayi9DfJYnm822aChB0Tm/zBksLwl16Kkk94t?=
 =?us-ascii?Q?T2AgUKFgwOiEZm6eEYMC2RcLgrglPOCwI5IOCfGObL9toAmqFJjL/OyAEcMc?=
 =?us-ascii?Q?NfN9yegGBrm0CIpmFeGZiq8Be+OZxd5tXoTWj9j1k7i26837U8Dy+9bqmaMx?=
 =?us-ascii?Q?8+EJiXoxXdlCjxzogUnhBOHQfsyI4Skv1GmDw49oLrXPW27iYVM2Zysp96Rm?=
 =?us-ascii?Q?7FHnrkyOtGsZUt7OUhy/StBp2bXvQGCzuDeKLlPxxGbRbYlKsUWe6bBZnitE?=
 =?us-ascii?Q?6I8TojDB6PYrC2YoXcgP/t6iZWF4w/ZZkB8EmhAkgUfQI2pGX7svm3JxCjDM?=
 =?us-ascii?Q?XK7lLhwtytDeXlCLEkxYlt+fo0nNeNIVl5rQi8y6gqxkfhaJYrpJ24MRk2kJ?=
 =?us-ascii?Q?Us8FHvrxrtFQSqtcq+VnBrB7E73Vv4tQhKxbi0YtIgNFSlock3o16y7Jv5Mh?=
 =?us-ascii?Q?l4jBqRg0GCaufG+Aiw7+YURAz6b2JESS5JgvQ3tap/cMuj/pNjyL43Jlkkgp?=
 =?us-ascii?Q?2J+8tYAc6M5hMw/LFpSLC+gtu5N8S4wE/UcI41mNUlwi3q4EGrK2rbriLFZl?=
 =?us-ascii?Q?BANOcgQCfPiyzw75n/xKKBdxk6cooJz5F+CoQh7tGnMfVXMtmmLStOBdHj5W?=
 =?us-ascii?Q?Bq2yCOoPQkLJQlsSbH5EBqAGopBTNDfsuV8cfmDjt8EPteUhIb6uaLQKEccu?=
 =?us-ascii?Q?aw2ZrJ0dFgza+aYEbnGwnKsV6Nklm1NwXTL8kIXm0b2nnldQ5ouPv8qcYqXD?=
 =?us-ascii?Q?pN+dBhhiyl29ZWe8G0HFwD4Iqa/qNKzV2TWAeXYQZbu0obY0375C3K1tEgRP?=
 =?us-ascii?Q?KhzIWB2rKNg7LpGAHkVZTLo/Yf/tu5X9kHpYi1hwEJU+4xvi09iLkYPLavJ6?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b0f2bf-eeee-4d48-57c7-08db2f29df50
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 01:15:09.0743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EQWbieNtBPFpMRdboUIxO3JXTFZGO1rrzc6E6lEsTWcuHAS9VrGWgMcdxyNin69lClEMbMh4zPNGDHw+xNL3qYrRfpOahLT1GbFg6sQGZsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4558
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
[..]
> >If we only need to know that this memdev is mapped in any region,
> >so don't touch it, we can look at it's port->commit_end. If that
> >commit_end >= 0, we can look at each endpoint to find the regions
> >it's mapped to.
> 
> I think this is a lot better than using the list approach.

Seconded, thanks Alison!
