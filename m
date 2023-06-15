Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC95EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 19:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjFOTSa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjFOTS2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 15:18:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1BE2952
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 12:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686856702; x=1718392702;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uu/DFqtcFIDgeBlKZ+smb2tJeAmSbYfum3QsuI1o2YU=;
  b=nG6mexp2qDASxXgvlGjXs0LCZnZ2pENTqKjUn1pu99/fch9+okzOttKL
   YR4WL9vtnxFVIEVxU06cE+vLhitm+yLqcMkZjHrNbBQuZfGAfb/A1FtD7
   3UQzSv7UL/TtfHTm2llo0lUBJACZBNDtUdyISzMesUwahbNxLkKa+UBNH
   Cawbu6FFVwVmnpaOsBUBsQxhMINFI7Ot68CIx0cXpVkcqwtVUYu2rEM4O
   2TKYYSKU4v65tKCPKnpyST1Vj7DB/2QEN9pFOGFCqg6DQeAFlEJ3wclSY
   ug72YF1bcjuJeLZPvv+QErpW3tm3XmItYeXoP4pyP0dMjb3eycsvFUvPe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="348723024"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="348723024"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 12:18:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="1042808732"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="1042808732"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jun 2023 12:18:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 12:18:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 12:18:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 12:18:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWHuIxdAi78FbvDfqVbdVuQcdZtNbkMkqeHsFSLOkxqyDEeCK8AuDxEDlAmxNoblVMLnuG0N47J6JGrNAPUdlhnM3NdkKdH+LFqB6SGZPfjSq5txMTsCb3cI5msJVdZXBuWrHwKtWJQnQt8j4VcBTQ2uM13/P5gZvT23fxhLVUbFKoIZNKkWqG266taL//qnJEv8qAoj0nq9cJ/CQNhXUgTuSg1WU6TFiH161gt21HTE7BTnx9tajWXOayp49SkAt6UCLHWKAtiBfqm+sBxhFQcb1U1XGNTm+l4fnJqDudM01dqVn5o/pQjXtL8w2JWmIRKVhGZ3fL6zbFmn6cmGMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJGkJ+0zk+t3NHB3AZAH4673BQSnzydO00hc4rYQ1Uo=;
 b=X0LT1hlf6kfr5YIgauhRujBPRriPHMEP/v+anuYZuFwN4LkFkhtE+C+XJOB7k50cF0rzCUxp2GI7Yy0AFgNBDkwrdogdoYInluHAef9I2ny0yYZwxJDKcR8vUOye1Qy4/b3/4PEkbEC8xQVPOf3cYiGDKxRzR2t/ia36rlkGQOGShhqS1O7c40jEux+r5DOSwA/H/pXN1qdkLvtmSAwM98Vkzbhf2LkGk3Jk33yRUPQzKcicKfkCnMxj27kZVKgZqQ46Vd/SM429gxR2BOAClyEpn4EzlNVHigwPuV+014hEE8pNb6kKTn3KALKjmrdvi0Cs6bQ+ZB6Ud1m/eDHQTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN9PR11MB5322.namprd11.prod.outlook.com (2603:10b6:408:137::18)
 by CY8PR11MB6820.namprd11.prod.outlook.com (2603:10b6:930:60::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 19:18:16 +0000
Received: from BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb]) by BN9PR11MB5322.namprd11.prod.outlook.com
 ([fe80::497b:51a8:9880:7eeb%7]) with mapi id 15.20.6500.026; Thu, 15 Jun 2023
 19:18:16 +0000
Date:   Thu, 15 Jun 2023 15:17:56 -0400
From:   Navneet Singh <navneet.singh@intel.com>
To:     Fan Ni <nifan@outlook.com>
CC:     <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <ZItj5KHQmHmnuKAG@fedora>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
 <SG2PR06MB3397D40835FA3156180F0249B25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397D40835FA3156180F0249B25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: SI2PR06CA0018.apcprd06.prod.outlook.com
 (2603:1096:4:186::8) To BN9PR11MB5322.namprd11.prod.outlook.com
 (2603:10b6:408:137::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR11MB5322:EE_|CY8PR11MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: d3fce6ba-0be4-49aa-acd0-08db6dd5454f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DduCobAaIIwM0CJEeJTt8d2YMdQGE81B/cCYFD6j17hgobGiRhfv6TE509+TbRndGl7Jy68wwXL7yhVGUxE6iKmVAdECDGzGMMGcWijVzQ7SuSwRNdNgnSaqO0uNOz/J/U9QNf4egelSgLwpiCr93Cfx/A1HN7cpzrUola6aGDJutOK8Ivbk0pIkH8oDCsK79wqnXSt1Zk3bJcMh82ZMU8l42DpPZYWhe8oWLl2qvbsX2GYADgGtbqvcLn1ZagOK31O6BCXupdsWL14K7GpZJPYM4Jzrbciu6iH+TD3C16XR8bI2smOWQ0jdmY/L/DICTqEkHQW6wCR0xuPbEGdkd1cJr5TVmNH8XT4BRtK4TJyLPWLEsAeOdW6U/hN3V2BBtL3Q842tN3D87qnA37Oj0T35sTIgTQpou8wpUFinkxNkFxYB38jvt6NT1+VE7uz+znEtPAC/AH3pK9sDbO2l41Kctgk/wHwg6lF5OrGn3uYGlAiKxKIeNomBd3te7aTkAq8+oThPhGgboZW7d0vOkgR93UV/6RTL4ZEjHB5G5GUwbTuufZ+ynvaEu9WpZxURBw/OJWmq5afdSivDJ1i0r1+nlWjkf7wTjKXZ3o05cckO7X+jvr1+H/KRe8WuX0/0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5322.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(5660300002)(4326008)(2906002)(8676002)(30864003)(66946007)(66476007)(66556008)(54906003)(44832011)(45080400002)(6666004)(6486002)(8936002)(6916009)(9686003)(26005)(6506007)(6512007)(186003)(316002)(41300700001)(82960400001)(83380400001)(478600001)(33716001)(86362001)(38100700002)(461764006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L5XxqFIG4j8iMSIJoqKK7NjMiX4Zx7UbhBwbQhU41iU886zqkU/zGvI7Blx6?=
 =?us-ascii?Q?kM2X/ugz9iwl642SUeKj25S/Ljyq+MvEdEev5R8KtjW1dhRYSpDg/umMalu1?=
 =?us-ascii?Q?hGrdAeEYyrH9orBqrfnHOO4zCQtsFTlWdj3153E+TS73VKXJYq46lRFJfPia?=
 =?us-ascii?Q?5eZ+1bZ8d/8H88aUelo+mgXZnohjOPrNYXVBDCNEz4UHs8tLo80lWy2MlQZz?=
 =?us-ascii?Q?e8jVraMlbYHPdbPf/JgpzKOjCJ7KCBtnPv02hUuKbNe3a7Ya70l57jz66Dx2?=
 =?us-ascii?Q?1ZVvcadnt8ljwn56rOInSlnECpSaGvRXzMbkRLgSKjIiVNu3dyobwj7LjNRe?=
 =?us-ascii?Q?BNFP/scgE8ir94dVn8D8YQOYoasRpvOYABWQea24ZdNFUWwrMC8Ub1/hPoqE?=
 =?us-ascii?Q?roB3spC6zUf2tAxlROYLNJRN2Nkvmr4ll03NIEoQlnOMZWSLi0xViqlbyoxA?=
 =?us-ascii?Q?yANqfnNppkgCRMVPqOX4I6wSWJo1pFSXJmLuOTfXg+OwHbm4Oaz1rLEdcTVI?=
 =?us-ascii?Q?rKyW9Faq7teIYrOVQZT2tMhXebAxlkuf6/qxe2j4UYBrY6gd/F0ptPbUqEgr?=
 =?us-ascii?Q?V4f54SRCFpGWeICKqutjD9dLupoMgb/GbpK8G8LlbOLiSu/jL9yUcM1vKhaF?=
 =?us-ascii?Q?ww0j1mrf6TQVb4Z3d/l/BPnZ/wSkjzX2asEwGsm3S6ghLZFeIcrx/p2WoLVG?=
 =?us-ascii?Q?LXgHHLMHQw6DeCALOd8vdpG1sprFcq1ut2ymAbAiEXpRQGeNq/rOI3cNT0yG?=
 =?us-ascii?Q?0EYq1sRi7e1p7QKXlpfKQ1ev2u0Ot40d5IZbFBJxEkx5N2ZMLUKZbYcunT2B?=
 =?us-ascii?Q?eWa16jDC0KSGThT7EujiYRTRLsrcMVfJ+2mIU8HztcO9YghBH0hAAIq0Y/iv?=
 =?us-ascii?Q?dlCR6swLsNVn7QisQHeA05f250D1Vn0SdJw10/stCpD6brV85gvCw2uGlYY2?=
 =?us-ascii?Q?CtDVzurfTkS+9jLoaw6Iu+1Fx4AY/PyXov15JiFp08UmL2NoYXl+xupJihh4?=
 =?us-ascii?Q?/pL+NRhwnRmeP1y65b0GHD8+hMPvwoGkLBw5GxxWVbEU2zigBHJ00S+yOsNR?=
 =?us-ascii?Q?7xAeljE0QtFLVhRS5Wnkjz5/PNqBE8pkbAfxhWq3umQYj3/kdaJiy3w09kIQ?=
 =?us-ascii?Q?u2CmA37j+RjOeg6L9nAMtkzUIm9l4odXwAq3YjTq/rhmjwdOPd6vrzfIHuzj?=
 =?us-ascii?Q?sf2eFniTkLaxAiWmFyAaSYdHMEuuC7fVxFWpOloZFkWkjGwIzn+qxqms5GuK?=
 =?us-ascii?Q?XbXoxdqBa6cY1Pp4NKU0cJ1/o4d2kUpwoKRySfATQmx8G/Izgx7vSYSQkebZ?=
 =?us-ascii?Q?wqk+QZYRavSFeXSlhsijwiwGvki0YY5mBNGxTSAiOSZnXQDWIrW91SXLAmjh?=
 =?us-ascii?Q?z5QxU8473cdSHxbpC7aUpTGIaPJ8+LU5ZxPN7rWpDpZc0+WyIQ5URZvjHwH7?=
 =?us-ascii?Q?vfhLglqYBp5IG+YDueWxHoSGOLgUOm/wSucRdGKE0TfQlpNDFOgzpqGiLLoP?=
 =?us-ascii?Q?9Sp9RrbZyXpd5bIlq+E5qHahs99e6Tw3L1key3X8o5vGPcl1aNooWsALg2mr?=
 =?us-ascii?Q?4qYETtSRZJfd0y/edS4dbgZC6c3uKEtwXS40y7AENXA4k8ppVSC3NHJ6AyXn?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d3fce6ba-0be4-49aa-acd0-08db6dd5454f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5322.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 19:18:16.4948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoXtUA9vKViuTb/K1lIvN/vHNLbPJpbLmRlvVMiYY3x+l1g6hwIWZi3gIcgbQ97qWH2EANhwBfYV2ly6UPbBkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6820
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Jun 15, 2023 at 11:30:08AM -0700, Fan Ni wrote:
> The 06/14/2023 12:16, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > Read the Dynamic capacity configuration and store dynamic capacity region
> > information in the device state which driver will use to map into the HDM
> > ranges.
> > 
> > Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> > command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> > 
> > Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> > 
> 
> See the comments below how total_dynamic_capacity is collected.
> 
> 
> > ---
> > [iweiny: ensure all mds->dc_region's are named]
> > ---
> >  drivers/cxl/core/mbox.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++--
> >  drivers/cxl/cxlmem.h    |  70 +++++++++++++++++-
> >  drivers/cxl/pci.c       |   4 +
> >  3 files changed, 256 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > index 3ca0bf12c55f..c5b696737c87 100644
> > --- a/drivers/cxl/core/mbox.c
> > +++ b/drivers/cxl/core/mbox.c
> > @@ -111,6 +111,37 @@ static u8 security_command_sets[] = {
> >  	0x46, /* Security Passthrough */
> >  };
> >  
> > +static bool cxl_is_dcd_command(u16 opcode)
> > +{
> > +#define CXL_MBOX_OP_DCD_CMDS 0x48
> > +
> > +	if ((opcode >> 8) == CXL_MBOX_OP_DCD_CMDS)
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> > +					u16 opcode)
> > +{
> > +	switch (opcode) {
> > +	case CXL_MBOX_OP_GET_DC_CONFIG:
> > +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> > +		break;
> > +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> > +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> > +		break;
> > +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> > +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> > +		break;
> > +	case CXL_MBOX_OP_RELEASE_DC:
> > +		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +}
> > +
> >  static bool cxl_is_security_command(u16 opcode)
> >  {
> >  	int i;
> > @@ -666,6 +697,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
> >  static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  {
> >  	struct cxl_cel_entry *cel_entry;
> > +	struct cxl_mem_command *cmd;
> >  	const int cel_entries = size / sizeof(*cel_entry);
> >  	struct device *dev = mds->cxlds.dev;
> >  	int i;
> > @@ -674,11 +706,12 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  
> >  	for (i = 0; i < cel_entries; i++) {
> >  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> > -		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> > +		cmd = cxl_mem_find_command(opcode);
> >  
> > -		if (!cmd && !cxl_is_poison_command(opcode)) {
> > -			dev_dbg(dev,
> > -				"Opcode 0x%04x unsupported by driver\n", opcode);
> > +		if (!cmd && !cxl_is_poison_command(opcode) &&
> > +		    !cxl_is_dcd_command(opcode)) {
> > +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> > +				opcode);
> >  			continue;
> >  		}
> >  
> > @@ -688,6 +721,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
> >  		if (cxl_is_poison_command(opcode))
> >  			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
> >  
> > +		if (cxl_is_dcd_command(opcode))
> > +			cxl_set_dcd_cmd_enabled(mds, opcode);
> > +
> >  		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
> >  	}
> >  }
> > @@ -1059,7 +1095,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
> >  	if (rc < 0)
> >  		return rc;
> >  
> > -	mds->total_bytes =
> > +	mds->total_static_capacity =
> >  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
> >  	mds->volatile_only_bytes =
> >  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> > @@ -1077,10 +1113,137 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
> >  		mds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
> >  	}
> >  
> > +	mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
> > +
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> >  
> > +/**
> > + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> > + * information from the device.
> > + * @mds: The memory device state
> > + * Return: 0 if identify was executed successfully.
> > + *
> > + * This will dispatch the get_dynamic_capacity command to the device
> > + * and on success populate structures to be exported to sysfs.
> > + */
> > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	struct device *dev = cxlds->dev;
> > +	struct cxl_mbox_dynamic_capacity *dc;
> > +	struct cxl_mbox_get_dc_config get_dc;
> > +	struct cxl_mbox_cmd mbox_cmd;
> > +	u64 next_dc_region_start;
> > +	int rc, i;
> > +
> > +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> > +		sprintf(mds->dc_region[i].name, "dc%d", i);
> > +
> > +	/* Check GET_DC_CONFIG is supported by device */
> > +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> > +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> > +		return 0;
> > +	}
> > +
> > +	dc = kvmalloc(mds->payload_size, GFP_KERNEL);
> > +	if (!dc)
> > +		return -ENOMEM;
> > +
> > +	get_dc = (struct cxl_mbox_get_dc_config) {
> > +		.region_count = CXL_MAX_DC_REGION,
> > +		.start_region_index = 0,
> > +	};
> > +
> > +	mbox_cmd = (struct cxl_mbox_cmd) {
> > +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> > +		.payload_in = &get_dc,
> > +		.size_in = sizeof(get_dc),
> > +		.size_out = mds->payload_size,
> > +		.payload_out = dc,
> > +		.min_out = 1,
> > +	};
> > +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> > +	if (rc < 0)
> > +		goto dc_error;
> > +
> > +	mds->nr_dc_region = dc->avail_region_count;
> > +
> > +	if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> > +		dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> > +			mds->nr_dc_region);
> > +		rc = -EINVAL;
> > +		goto dc_error;
> > +	}
> > +
> > +	for (i = 0; i < mds->nr_dc_region; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		dcr->base = le64_to_cpu(dc->region[i].region_base);
> > +		dcr->decode_len =
> > +			le64_to_cpu(dc->region[i].region_decode_length);
> > +		dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> > +		dcr->len = le64_to_cpu(dc->region[i].region_length);
> > +		dcr->blk_size = le64_to_cpu(dc->region[i].region_block_size);
> > +
> > +		/* Check regions are in increasing DPA order */
> > +		if ((i + 1) < mds->nr_dc_region) {
> > +			next_dc_region_start =
> > +				le64_to_cpu(dc->region[i + 1].region_base);
> > +			if ((dcr->base > next_dc_region_start) ||
> > +			    ((dcr->base + dcr->decode_len) > next_dc_region_start)) {
> > +				dev_err(dev,
> > +					"DPA ordering violation for DC region %d and %d\n",
> > +					i, i + 1);
> > +				rc = -EINVAL;
> > +				goto dc_error;
> > +			}
> > +		}
> > +
> > +		/* Check the region is 256 MB aligned */
> > +		if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> > +			dev_err(dev, "DC region %d not aligned to 256MB\n", i);
> > +			rc = -EINVAL;
> > +			goto dc_error;
> > +		}
> > +
> > +		/* Check Region base and length are aligned to block size */
> > +		if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> > +		    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> > +			dev_err(dev, "DC region %d not aligned to %#llx\n", i,
> > +				dcr->blk_size);
> > +			rc = -EINVAL;
> > +			goto dc_error;
> > +		}
> > +
> > +		dcr->dsmad_handle =
> > +			le32_to_cpu(dc->region[i].region_dsmad_handle);
> > +		dcr->flags = dc->region[i].flags;
> > +		sprintf(dcr->name, "dc%d", i);
> > +
> > +		dev_dbg(dev,
> > +			"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> > +			dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> > +	}
> > +
> > +	/*
> > +	 * Calculate entire DPA range of all configured regions which will be mapped by
> > +	 * one or more HDM decoders
> > +	 */
> > +	mds->total_dynamic_capacity =
> > +		mds->dc_region[mds->nr_dc_region - 1].base +
> > +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> > +		mds->dc_region[0].base;
> 
> The above code assumes there is no DPA address gap between two adjacent dc
> regions. Not sure whether it will always be true or not, I cannot find any
> specific statement in the spec. 
> 
> Fan
> 
Navneet - Total dynamic capacity name gives a perception that its a sum of all DC regions but its
a DPA range which contains all the dc regions. Each DC region is added
as child resource to it. While allocating the DPA gaps between the
regions are taken care to skip. Maybe a better name would help here to
avoid confusion.

> > +	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
> > +		mds->total_dynamic_capacity);
> > +
> > +dc_error:
> > +	kvfree(dc);
> > +	return rc;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> > +
> >  static int add_dpa_res(struct device *dev, struct resource *parent,
> >  		       struct resource *res, resource_size_t start,
> >  		       resource_size_t size, const char *type)
> > @@ -1112,6 +1275,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  	struct cxl_dev_state *cxlds = &mds->cxlds;
> >  	struct device *dev = cxlds->dev;
> >  	int rc;
> > +	size_t untenanted_mem =
> > +		mds->dc_region[0].base - mds->total_static_capacity;
> > +
> > +	mds->total_capacity = mds->total_static_capacity +
> > +			untenanted_mem + mds->total_dynamic_capacity;
> >  
> >  	if (!cxlds->media_ready) {
> >  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> > @@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
> >  	}
> >  
> >  	cxlds->dpa_res =
> > -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> > +		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
> > +
> > +	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
> > +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> > +
> > +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> > +				 dcr->base, dcr->decode_len, dcr->name);
> > +		if (rc)
> > +			return rc;
> > +	}
> >  
> >  	if (mds->partition_align_bytes == 0) {
> >  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> >  				 mds->volatile_only_bytes, "ram");
> >  		if (rc)
> >  			return rc;
> > +
> >  		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> >  				   mds->volatile_only_bytes,
> >  				   mds->persistent_only_bytes, "pmem");
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 89e560ea14c0..9c0b2fa72bdd 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -239,6 +239,15 @@ struct cxl_event_state {
> >  	struct mutex log_lock;
> >  };
> >  
> > +/* Device enabled DCD commands */
> > +enum dcd_cmd_enabled_bits {
> > +	CXL_DCD_ENABLED_GET_CONFIG,
> > +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> > +	CXL_DCD_ENABLED_ADD_RESPONSE,
> > +	CXL_DCD_ENABLED_RELEASE,
> > +	CXL_DCD_ENABLED_MAX
> > +};
> > +
> >  /* Device enabled poison commands */
> >  enum poison_cmd_enabled_bits {
> >  	CXL_POISON_ENABLED_LIST,
> > @@ -284,6 +293,9 @@ enum cxl_devtype {
> >  	CXL_DEVTYPE_CLASSMEM,
> >  };
> >  
> > +#define CXL_MAX_DC_REGION 8
> > +#define CXL_DC_REGION_SRTLEN 8
> > +
> >  /**
> >   * struct cxl_dev_state - The driver device state
> >   *
> > @@ -300,6 +312,8 @@ enum cxl_devtype {
> >   * @dpa_res: Overall DPA resource tree for the device
> >   * @pmem_res: Active Persistent memory capacity configuration
> >   * @ram_res: Active Volatile memory capacity configuration
> > + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> > + *          region
> >   * @component_reg_phys: register base of component registers
> >   * @info: Cached DVSEC information about the device.
> >   * @serial: PCIe Device Serial Number
> > @@ -315,6 +329,7 @@ struct cxl_dev_state {
> >  	struct resource dpa_res;
> >  	struct resource pmem_res;
> >  	struct resource ram_res;
> > +	struct resource dc_res[CXL_MAX_DC_REGION];
> >  	resource_size_t component_reg_phys;
> >  	u64 serial;
> >  	enum cxl_devtype type;
> > @@ -334,9 +349,12 @@ struct cxl_dev_state {
> >   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
> >   * @mbox_mutex: Mutex to synchronize mailbox access.
> >   * @firmware_version: Firmware version for the memory device.
> > + * @dcd_cmds: List of DCD commands implemented by memory device
> >   * @enabled_cmds: Hardware commands found enabled in CEL.
> >   * @exclusive_cmds: Commands that are kernel-internal only
> > - * @total_bytes: sum of all possible capacities
> > + * @total_capacity: Sum of static and dynamic capacities
> > + * @total_static_capacity: Sum of RAM and PMEM capacities
> > + * @total_dynamic_capacity: Complete DPA range occupied by DC regions
> >   * @volatile_only_bytes: hard volatile capacity
> >   * @persistent_only_bytes: hard persistent capacity
> >   * @partition_align_bytes: alignment size for partition-able capacity
> > @@ -344,6 +362,10 @@ struct cxl_dev_state {
> >   * @active_persistent_bytes: sum of hard + soft persistent
> >   * @next_volatile_bytes: volatile capacity change pending device reset
> >   * @next_persistent_bytes: persistent capacity change pending device reset
> > + * @nr_dc_region: number of DC regions implemented in the memory device
> > + * @dc_region: array containing info about the DC regions
> > + * @dc_event_log_size: The number of events the device can store in the
> > + * Dynamic Capacity Event Log before it overflows
> >   * @event: event log driver state
> >   * @poison: poison driver state info
> >   * @mbox_send: @dev specific transport for transmitting mailbox commands
> > @@ -357,9 +379,13 @@ struct cxl_memdev_state {
> >  	size_t lsa_size;
> >  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
> >  	char firmware_version[0x10];
> > +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
> >  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
> >  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> > -	u64 total_bytes;
> > +
> > +	u64 total_capacity;
> > +	u64 total_static_capacity;
> > +	u64 total_dynamic_capacity;
> >  	u64 volatile_only_bytes;
> >  	u64 persistent_only_bytes;
> >  	u64 partition_align_bytes;
> > @@ -367,6 +393,20 @@ struct cxl_memdev_state {
> >  	u64 active_persistent_bytes;
> >  	u64 next_volatile_bytes;
> >  	u64 next_persistent_bytes;
> > +
> > +	u8 nr_dc_region;
> > +
> > +	struct cxl_dc_region_info {
> > +		u8 name[CXL_DC_REGION_SRTLEN];
> > +		u64 base;
> > +		u64 decode_len;
> > +		u64 len;
> > +		u64 blk_size;
> > +		u32 dsmad_handle;
> > +		u8 flags;
> > +	} dc_region[CXL_MAX_DC_REGION];
> > +
> > +	size_t dc_event_log_size;
> >  	struct cxl_event_state event;
> >  	struct cxl_poison_state poison;
> >  	int (*mbox_send)(struct cxl_memdev_state *mds,
> > @@ -415,6 +455,10 @@ enum cxl_opcode {
> >  	CXL_MBOX_OP_UNLOCK		= 0x4503,
> >  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
> >  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> > +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> > +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> > +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> > +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
> >  	CXL_MBOX_OP_MAX			= 0x10000
> >  };
> >  
> > @@ -462,6 +506,7 @@ struct cxl_mbox_identify {
> >  	__le16 inject_poison_limit;
> >  	u8 poison_caps;
> >  	u8 qos_telemetry_caps;
> > +	__le16 dc_event_log_size;
> >  } __packed;
> >  
> >  /*
> > @@ -617,7 +662,27 @@ struct cxl_mbox_set_partition_info {
> >  	u8 flags;
> >  } __packed;
> >  
> > +struct cxl_mbox_get_dc_config {
> > +	u8 region_count;
> > +	u8 start_region_index;
> > +} __packed;
> > +
> > +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> > +struct cxl_mbox_dynamic_capacity {
> > +	u8 avail_region_count;
> > +	u8 rsvd[7];
> > +	struct cxl_dc_region_config {
> > +		__le64 region_base;
> > +		__le64 region_decode_length;
> > +		__le64 region_length;
> > +		__le64 region_block_size;
> > +		__le32 region_dsmad_handle;
> > +		u8 flags;
> > +		u8 rsvd[3];
> > +	} __packed region[];
> > +} __packed;
> >  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> > +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
> >  
> >  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
> >  struct cxl_mbox_set_timestamp_in {
> > @@ -742,6 +807,7 @@ enum {
> >  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
> >  			  struct cxl_mbox_cmd *cmd);
> >  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> > +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
> >  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> >  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> >  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 4e2845b7331a..ac1a41bc083d 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -742,6 +742,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (rc)
> >  		return rc;
> >  
> > +	rc = cxl_dev_dynamic_capacity_identify(mds);
> > +	if (rc)
> > +		return rc;
> > +
> >  	rc = cxl_mem_create_range_info(mds);
> >  	if (rc)
> >  		return rc;
> > 
> > -- 
> > 2.40.0
> > 
> 
> -- 
> Fan Ni <nifan@outlook.com>
