Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5844BC32772
	for <linux-cxl@archiver.kernel.org>; Tue, 16 Aug 2022 20:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236875AbiHPUwB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 Aug 2022 16:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237042AbiHPUvy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 Aug 2022 16:51:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD01289CD0
        for <linux-cxl@vger.kernel.org>; Tue, 16 Aug 2022 13:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660683113; x=1692219113;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MgZtZBJBdI/3A3ricMS2dYxBqKp0nx7TQfiRbWZeyIA=;
  b=LxFdrl4taO4vR/HOSr4IPtyS9MA5CcXUcdoOfBvRZVHZAR9qDMJKXaY6
   akWgIVBncpC6Ej9g8RddFEi68u+CkR3zY+H66EWf66N7uAtGShVypkjku
   RADlXIm5dPZnY2CKaBUglqumixrGZ7B6hbaoKXp2dMPeaL1dr9wj1ym7o
   bnhBN5zEUqf+ldw3rsX0srOtU1MUlb4Kc22dGFtmjqGm9eE+J1E5W4LfM
   S+ndU12fTxR+L19X5oI0gHWGq6wGBYgBx3mJkLkidkMr6x9RZzqmRfPAH
   7s+GSU5yZ0ihpA9gg8AcgRgaYTTCO6pqA3hC8DLuISn4Jy/as4TIYw2ht
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="318326925"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="318326925"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 13:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="935075673"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2022 13:51:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 13:51:53 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 16 Aug 2022 13:51:52 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 16 Aug 2022 13:51:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 16 Aug 2022 13:51:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4nKtB2B0pqtjxPI3qhFGO2OO0ww7ZyRiJg4P2VzV3xDy5CPENXk/UGMIZFduntrzZYJ9TsSsChLjQx01WcrHiG3PfIpr5yYx1FOjhQKnr6Gu+TCPr/nG3/gM7Xh0q7Q1zfKR6tY+VhHyGjb5SGFq2IrM7CIEld193qaEJUpk9OPiTg9qsbJkfEVfCg+hdygE1OXm3Z0r3bXhMEIBva+wH9xn0iu12MQGRCm4UBR6Kos9UjXQ5Vb4rt4RJbHf9retvdjl1d89TmVbY9BZ/O2/cUpiVQ2Kf/gOSVNM7qiZyi/497b7jqiXNuCojkKfjXmPD0Gn2Em4gXTRz7xHuAszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIY0SKSptnyBj9cQFvIg4c5f8rqusfq1TC6LNvw/pWc=;
 b=mavxZYYWqjDBG2mN+WvPkQIf32YCqrIWUXWAhVHFDCH/XYM8cL9AjBu9xdTmURofrmPxipRIWdiz3rLcVCiZbAQmy1jLXAu4nN2Mq8uenvXzC7NCMDCXuP/g/mH+0qKXXvl4h8rPSInbpUJQ8sqzmtKrst29AwpJU5BYh63BjS23rx6WQhMyOcu0WiOP48/sMtTuIOZCfOUl0Y5lQkt2o6iDClYrFr7mkZnNVLyYc/b/KEdBgVrqA7J77O9GokNh6BD++7/kgd/68okp7MK7qo0Ieo7UknQ3cc6iUI3O7XKWPWFAYhdCzRLavFAfl2SFs03uvMotAWLjtHItFwdhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by SA2PR11MB4971.namprd11.prod.outlook.com
 (2603:10b6:806:118::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 20:51:50 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.028; Tue, 16 Aug 2022
 20:51:50 +0000
Date:   Tue, 16 Aug 2022 13:51:48 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>
Subject: RE: [PATCH 2/2] cxl: export intereleave capability as port sysfs
 attribute
Message-ID: <62fc03645e896_f2f512947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <62f5c76060f1f_3ce6829494@dwillia2-xfh.jf.intel.com.notmuch>
 <166067375610.1614719.3464893539111383781.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166067375610.1614719.3464893539111383781.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: BY5PR17CA0062.namprd17.prod.outlook.com
 (2603:10b6:a03:167::39) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 967b467b-8178-43fb-1b81-08da7fc92497
X-MS-TrafficTypeDiagnostic: SA2PR11MB4971:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XAbVKiVWpbK8bngFqBTrtdsYNqBXYSRnY0ieOoAzO02vAih3k3909QDHUnjncdyeEGSr8oOC/nFOTBKEoGjJSlUMBrKEJ7NQEEAWah0miqMptYoBvTXmfINMEYONjRYHRzWgK88YvvY4YMtFDwNYxMPVHqaRZyTtleN/325q/Yz/iARhMydiMrjEpohV8soOKpUIiYP3Q9oqHOdb7DmZ2C/6jC60mhl9zOASRsBtqdGO+R7qUNJcHGRWwkMbTHoki2NRTCUMrL9IeJDoNelfB2FvVCZg8cjSRDl8lUlhjE6oYrfDbpOhG7DBHfBi6riHt9nWi8nx0utfJm5t9Faf09CUnEZQ1X2RipNL0UHb6hrVnxIMhFk28s4qFadPdsg+ei0AbhrAAQPzyqCC5OazudbYxNOCIIDVnpQXUhV3edtHO/kWZ88zMhE4oiQtSZ6viCg5fV9kjcGQb6LhNDxkoo2XsDc0q3RD5XtIa4Ejmq1M4i9tJYZ5G2b8OWqClC6kEGVl2dgP93et9gq3/xDs9JdnZfUB7a8wsHIfsRHCXgNMQn+6eE+Jz6Z2pY3pPZ3gc8lQkAUuWdgtR5lc1Onh6SMJR1vyXyiN17eGYalIzmxCYfcC6dd8Il1B8eVi6gu9uSLjRSPQhudwXsmQBX/YIi0gcxFdxUK2IDcG1uTmbRFbRqfkr0aX4LTq6fhCC3NkiKLnjPOolw+NwY7Yzjf9AEdwJ/z62pCXo26Yd0TRigRd321dCQcUbKzK4pRw3rF9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(376002)(136003)(39860400002)(396003)(8936002)(41300700001)(6506007)(6486002)(478600001)(9686003)(83380400001)(26005)(6512007)(2906002)(186003)(107886003)(5660300002)(316002)(82960400001)(66476007)(66556008)(4326008)(38100700002)(66946007)(8676002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w/LVoJ+TNeiOaqATB4bmHpyGcXznuASu4GmGhV74StI7pJ6Q39b8R4lhYUni?=
 =?us-ascii?Q?j+H0BOf6rVYI5Y1AAC+b6P38YqiIP6Y0IHTmftfNpNizFuLsz12h4ST+mVOv?=
 =?us-ascii?Q?6GD1oWQeIuiQ5wogDvOQ4V8joi1NGh3SjOWpRmv89PnlEtaOOopmYrqG76/y?=
 =?us-ascii?Q?MRMDp2GfPpRs/nLfJ79ghYkiKClKjVINoMJ1CdVCqIyu1mb29Wz7jdtk9dgX?=
 =?us-ascii?Q?0/hu6rT/ET+Nv2im2cEILSUIcYM8ochlFFV8iAswsH7m3N94LyBCHrkT4Zdz?=
 =?us-ascii?Q?m+qwGP6j1OtpMMm2DbDBRX1P6D5oi7v/2/ylZz2di7tDdSltdpVWriAoYE6I?=
 =?us-ascii?Q?wD2zlWUD3AG0Hldo1VxMYFUbWciu0AE+dytBlQbqSBVLjnzrWUccaEdaj0ll?=
 =?us-ascii?Q?DUg3Z8eu2gUBf9cM70BOkNRaDoEPFKVooA3+ljB09cLUEukjoMaoKJzkmP+L?=
 =?us-ascii?Q?LVk2n44+4MdrHFqjED+PORuxfGgyE8EkBizf+wrw2rXWelJ5bSbwEdJ6QrRW?=
 =?us-ascii?Q?q52NgcbyP48aW2O7ZDKCWhAamRYp68N28mnCvw125j8yKKPlouKqyu3lQ5tM?=
 =?us-ascii?Q?ltJoXvT0QL5R4nZHm1m72z5MoROqqSx0/6yktLoBnhu1/dBbRo2c+aF1IZku?=
 =?us-ascii?Q?uwAOWpONSTp0DmdkF9tIA4XL0WIdVIIqgroI0tZG0675IoAhteJzfXeyzfCK?=
 =?us-ascii?Q?+TiKKbvKAireBXgUQ7mWC7/FVQCti8kdRCwB8ogfGeS/0EyGIFhohAhGY7+e?=
 =?us-ascii?Q?NwT/h690vU7xbc+s59gpA+UT5w34RRJT1axiuDjzEMI5X9K04u3AwKKf19g4?=
 =?us-ascii?Q?GcZZ07sxlVqrc7EO3gkCaeJVsxPzNufksXNwFU5nLU48DnD2n6xfBdMZQ6HR?=
 =?us-ascii?Q?V5L9rXdzjESRZKVhCv4I2+D4/2b4A6mBAGyRkYiBLplHwooYp379tMDhBhA+?=
 =?us-ascii?Q?0GnXTox9L8Z2bzA1okdlXijI8Tj3N5gx95TBgLEg/jDKSPI14SqWNbrU9ylO?=
 =?us-ascii?Q?g9sZG+na5JMRMCHSRsOdRNl64Y8/UIFXD5f6nfiD8oX4m/XKinX3KfkVHJuy?=
 =?us-ascii?Q?6MNg/0GYWJVXO/9o8vcY35+H9rssMqg4CCgvUi1IiQTKRsmTI7PqzWfdhw2w?=
 =?us-ascii?Q?dgZhGDueiGADGI7t53WGJeNhuoYXuMiVgd+mfdmeCHCGCwGhQWqDLrYPlOC7?=
 =?us-ascii?Q?f3a8zPpm1S6PkO/duHwxS4tOkb0QJJIDN8CEOnoEyXAh9rwPvh3YTn2sV3kM?=
 =?us-ascii?Q?woLv7xnMexsCipaYr6bvXwgcqfvKNOelnLEsldNL+nMIy7nSmYDlc7R2qoC6?=
 =?us-ascii?Q?T58wTF2gb7QLkXR/PBG1jEGij7Lg6SWlAhBQzkx1K9+0wBYSCVMTbVpOCB9V?=
 =?us-ascii?Q?GeUgfdR2QhcB8ww4TOnMTWpIyLXfNaoVsEYuWdRMTRf93hCk2yD1xbXOeUef?=
 =?us-ascii?Q?ln6fg+SOAd14TOlUie1gxPcG02V3u9wgjOP4SPi/R1C5uiTPP5mqcXGwYbMp?=
 =?us-ascii?Q?2wMx4GKMSt6jBExTZP4IIHJZmEwAeGuNiJWfIEFfm8n8MU8//kB3Lc+DQd0u?=
 =?us-ascii?Q?lLTVUznKsDUA5B8hLyGrl5oSpMp7bUKkezxtg8qYwtWq+LTDcMspEAWWRfFU?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 967b467b-8178-43fb-1b81-08da7fc92497
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 20:51:50.6789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +DHGJnqTg0eDb1kSuQCSPxZOr+tRFTB37oqNFCVmr1YHjqBrFd1uNbiwS8KpLIyD+gcuz6kLSIr8r5lXqbas3g5qnq75Ehd0N+UnvtlDCJ0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> Export the interleave capability as a sysfs attribute for a port. The
> exported mask is interpreted from the CXL HDM Decoder Capability Register
> (CXL spec v 8.2.4.19.1). Each bit in the mask represents the number of
> interleave ways the decoder supports. For example, CXL devices designed
> from CXL spec v2.0 supports 1, 2, 4, and 8 interleave ways. The exported
> mask would show 0x116. The exported sysfs attribute will help user region
> creation to do more valid configuration checking.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/port.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index e3e93e1b663e..231cfe888918 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -135,8 +135,21 @@ static ssize_t interleave_mask_show(struct device *dev, struct device_attribute
>  }
>  static DEVICE_ATTR_RO(interleave_mask);
>  
> +static ssize_t interleave_cap_show(struct device *dev, struct device_attribute *attr,
> +				   char *buf)
> +{
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(dev);
> +
> +	if (!cxlhdm)
> +		return 0;

Similar Documentation + "delete this check" comments as patch1.
