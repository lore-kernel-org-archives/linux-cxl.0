Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA4AC7EE23
	for <linux-cxl@archiver.kernel.org>; Thu, 18 May 2023 19:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjERTGT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 18 May 2023 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjERTGS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 18 May 2023 15:06:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8925A9
        for <linux-cxl@vger.kernel.org>; Thu, 18 May 2023 12:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684436776; x=1715972776;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=svojg6p0Vkhc3IrmvxAZIiti/0vT2ZinEG5sq+S0yMI=;
  b=WXqHW6gfAkxtUQLxhzjHdHCBb9ttNwhErIhh/sMJpLonceJRrbi5Z3x/
   /7L4rNXhTXlicHPpARYUbXtPOUXrKYslrfVx9Vf6m4pC/efhnj1JrxfIB
   qAn8hKotDfXEmgP++A2Y7jtEP4J/5p2hkl8NaP95Q3pjIlU9q4eqBTpEW
   3MQPy5tPfCYGHe/utSYPSTCHgorfuiObBWOTP3An5yNX3bi8DjkAg0TZ8
   e7O9fgK5obTE1yvfbORmZLdGk6DCfTBMbFxfFwWSfA1p7XKc6dgYM6Rze
   w4N0penrlAc5WpbytgtUeENW6+Na5BJKd1+mghG9kA5rsK5N/P+qnmgG1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="351004538"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="351004538"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 12:06:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948803572"
X-IronPort-AV: E=Sophos;i="6.00,174,1681196400"; 
   d="scan'208";a="948803572"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 18 May 2023 12:06:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 12:06:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 18 May 2023 12:06:01 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 18 May 2023 12:06:01 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 18 May 2023 12:06:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQoR0QGAf7ICfs7A6NIbRCCgLQVqP8Vxka0zMU1SkOELc3JehnbD8LEoi5wWw+9no1VlqusuizphVrWCVKBL8pXY+egxU0VTnnKalLv2ysMNBPxph2F2GIB/Obb6t+K0TExeUH06WtV0cJzCovX+h4aYdrk9v0oZOt7fD77uuw8RTgTNnHLPJuOUf81gUI1VEsV9aCGlBPHZ16heMjnTqtg2SphWqqUCeFbthcblBXSBAEQpbzTTHsZCyg69hWrjG0wyExc/UCY+utYgHP+ivHGmPyFoMOQlaI+kJ5DFJfbti2QuGHrOvbG1l6yUq9qDTSEbdmB17l3WRFe1emgPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Njx6rfUw56PSqwa3tTzlNaEP2+ghAHqE7O81C07puTo=;
 b=h+RAMTEhxIVj17cGfUiWWjASS570zPJ/FGKhLb6eOne8vdDhvlifd3ZHPt4Fxyo3GBoSSQXDSehid5p1RrRsZTlsTQ4jWkVt3GucmlID4hCf2WKY089Vha0qhgWzvGmdufoqG2MbVU6ekq0pV51+BjHGglay54qI2PYel0G9DSyW3I2j241mcEnm8Rrc83vgeEDUu7WiWUWNRLI4GRFH6z1lNlThbC6WME1Xr4s4NYN26yx6amZ6Kh3jZG46L+jdiJZawYT8hke7qaXWqFDU03ifM7UtyreFTr+19ogRy628RW+XQhz2HtKm94lg+qunPN74Y1HnA/7TmzwD23NkRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Thu, 18 May
 2023 19:05:56 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 19:05:56 +0000
Date:   Thu, 18 May 2023 12:05:51 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        <dan.j.williams@intel.com>
CC:     <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] cxl: Move cxl_await_media_ready() to before
 capacity info retrieval
Message-ID: <6466770f2c573_114f602944c@iweiny-mobl.notmuch>
References: <168443095459.2957452.1648087475761987955.stgit@djiang5-mobl3>
 <168443110845.2957452.15022248373553807511.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168443110845.2957452.15022248373553807511.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cfdc649-7f59-4353-836e-08db57d2e85c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GL7oybJWXBiNmWLAQitJ6ltgXdq3DevVbwOHctlHZ6H8MVQeHqLRasjWNz0ehaSP6MPj/tpmwAETzYm69jOVgfpR86dY+nMqfbp2dW3zLSA4LF4uesykPDF0DlJ27W4a5vLClPF+pOWAgjqjVNh9s2uLpgZwVh5un2bBEjOvWe5yFKG1XpsuuZPH4q3IY4LvW6+mz15UvyABmTITcEeHbfuF1EyZaoST13r+a6aE9uBteOMI0mH+AmivShg93UQ8IJEoRl6BCxCyGB8nuHDwVcwMsHM2AYDialPmsCjYrQqfi4qVtufUtQ+w8pEdDbRiKWZOAcgKUJDLewuvjBNJFQ7mnWtyO+6sU4Xm0+3Z45SAiGpQilyEyrJSkSg6qNUxdMHp1ypvLa+Pc2xKiWXnXwwIar/6OXW9G3Us9M4OhLVOs0YViyWKAsjq0M6FrkpR3b/87NBnGKmDeWtVPO3W5kVeQz7KLwNAdq9N+p2j0djvy2tEPaEfGnfuxevPd3jOgi9jSFW9y8xbx0lVjT3EKMITxDz1G3ID1u2SjhAUHyXpsF9dvvUZl3dQiYEiBk/v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(86362001)(82960400001)(41300700001)(38100700002)(5660300002)(8676002)(6636002)(316002)(4744005)(66476007)(66556008)(66946007)(2906002)(4326008)(186003)(44832011)(6506007)(6512007)(9686003)(26005)(8936002)(6486002)(478600001)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XbcXbGSjURAKW2erX9TGEld7o4bVll5sNYeshKejoTNqjqio5KsFiQb+WEdR?=
 =?us-ascii?Q?5pdbpHWjj+eSrEsvcGhDyZ0HqvjiVPRi1Gez46412+cwv1Fsul0nzePqzdRp?=
 =?us-ascii?Q?XznJBTZ7oR0rPaxXC5zVJzgZ4A+ks92yUTN/tsBoTFDeIIxo3zdSBGWSnB20?=
 =?us-ascii?Q?CKLBg5+/hro0PVOQbnhfChI36zrmjKY4dobDkIJAfe/fnaTlpiBZYeRzEZO0?=
 =?us-ascii?Q?IhS8NmNICadG329NlNxin32aAGmTlv47qHNY/ossuEj59EIHK0NYwKfHT3Zh?=
 =?us-ascii?Q?2AQtGNMVii4+UcM5x0+aNxU2NmcqzvxyA3R3ebjDQRsNV84TjkM608PxlGyn?=
 =?us-ascii?Q?HuDp9QyCbRFP0cc2KWus18T69kALLZEHSQkq0Ru1as0nibQUTsrxVxAPDLKe?=
 =?us-ascii?Q?AemVHsnsp1zxkz00mLX8L5EbMHSH+7+eJ8G0U51C0Fk5Vlk22Wg/OhjVczya?=
 =?us-ascii?Q?f/FKm+SJPRpoNr52Dzn3IN1GOsrIeuNVh/c5q3eyfGMHDdIaUgcplbJnrfB9?=
 =?us-ascii?Q?X6AXD3gZ/MdCeRwuJF3hMnHpyyRMABQAJO42vM2FzqTrkjfI0LNkp/sbRqA+?=
 =?us-ascii?Q?QznXOhpjpYlMOlPAD2PIG3p9E5SkTUnzyLEvOWgsbGFNd9gHOIqqAEl3bXuo?=
 =?us-ascii?Q?V2asIh62+9pyCCNlwOHk/SBRcW9Wi56wfyMmEZM1d9DHWeWGB2zSF5SDhGXH?=
 =?us-ascii?Q?N4f1hWkPvVn9CPIEjkDhPsBzcIRRU/L+bbjWA64PAmnEcFvpdurUxujpkbvB?=
 =?us-ascii?Q?nWcG+b0GLl5Ng6kAc6Olj4zz0Wz7wIWfaqkL9QWpwh8raoON6NHdWcjysEmQ?=
 =?us-ascii?Q?s5dv86wv7/fVUt6I9a971ZpaGb8ZU+12QDfAmVEXp1xXokw2UPbkwGFPwc2n?=
 =?us-ascii?Q?dYq9lN4vJhAcAQqxTHCPubNmExqgknLAe6dIYf5mrO0JK2xUAu5isRdspdWu?=
 =?us-ascii?Q?Ob+Y+cSIe2YrNaa6HJULf2fF3Lql8Ko8qScOmUjRIyEnr9ItVb/SfmLbWXwB?=
 =?us-ascii?Q?gIfAx3Npie8bRiP7nI+yjlaxDiKPr1xVVw81TzXU+53yTOyTZihr+maa4kA/?=
 =?us-ascii?Q?IBxPto0xDTkXFI/HKW6Ax2LuRgBnzOQnCgNutPzm8RCH67CZfAbom4JGX1cg?=
 =?us-ascii?Q?pbm82nqU/3VKNujyksR4bN1lx3lUGR3YPxNcQ0ftFcqhb9A0eTjQxg0iOk9Q?=
 =?us-ascii?Q?Mk9K1/0u1bjWGjxQfCEbObE6RnEWmcTMIAKBWa+bbB8tMVqWH8uOXw61VnO7?=
 =?us-ascii?Q?nbdKQInHiTSij5UTOsaSoBa7h6i9wlas6eoYODwJlNODTEWwzaBkMqsLdvhp?=
 =?us-ascii?Q?dEjj3ZWlAGOoZsLdzp8eENzizrABmj7Rdh8pdua1Da6kd/jSbZZuEwLkWVlX?=
 =?us-ascii?Q?MyCC3eqZLNTlaebAiwFZambrFzR2LvWrHxlJJLlhbnRr9ZlJ9YIFPGCLRUzt?=
 =?us-ascii?Q?Nk1O7idlOdJoOq/1TJKodDlbd+fnAHzAnbpIcdv6tj2fQ4fvCmy5muaACYxP?=
 =?us-ascii?Q?Fl4JN+AOdyYZrRODTjH2GcDke7EWIIbNEc8Cfdk9iey5RM3tDLwFebpCCxgB?=
 =?us-ascii?Q?3tdQ6RIe7gt6YrY2E8VnKULdGOERSVvPCFpoc9VB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfdc649-7f59-4353-836e-08db57d2e85c
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 19:05:56.3288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXZByMrv5NrbyF/dpbiQCLCLSukpCZfcxtCFzXTkpagNEuN1/WOovZF4HsJNedq0g/17R2DMinSespYMHAdOvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6435
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Move cxl_await_media_ready() to cxl_pci probe before driver starts issuing
> IDENTIFY and retrieving memory device information to ensure that the
> device is ready to provide the information.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
