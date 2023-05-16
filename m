Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C64C77B75
	for <linux-cxl@archiver.kernel.org>; Tue, 16 May 2023 21:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjEPVNU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 16 May 2023 17:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEPVNT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 16 May 2023 17:13:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A2E121
        for <linux-cxl@vger.kernel.org>; Tue, 16 May 2023 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684271598; x=1715807598;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Xi2hPETBqaZh1Yze0h6D0PHMOY83w3ztgDUyEs/hjHQ=;
  b=Fe4B7fT+nW/cZbsnyTfWYdM0LDNXAgj7T4FciUJu2OWN0t2pWVtWSo8M
   kAHpfzmSdQHPPVH4OMY5clgjfiTXzgHo2aM33rFPqgCd0dh5Fu7DBLvJf
   mJFchN/dhUpCW6LNtGCe4CmDj7HYXVYe+YYwdWIxoP0qVhYgiXfdzP/49
   /BY5WdJz76WwuVKNudJimMV1PMoHxMJVVnULq624iUe6QYSdAWKAhoEEz
   m+mUgi7Ey7I7ihVpmcGH1PLaZKgwselrKSfD6QIm7b2zAm8afxAFMCEQc
   2dar7qwPgvKZV7f/TnB9nVXBOmiqdvJG8sS0IRIZ1Lb27+U6qeM/Q2WqI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="336145896"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="336145896"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 14:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="679010641"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; 
   d="scan'208";a="679010641"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 16 May 2023 14:13:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:13:17 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 14:13:17 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 14:13:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONaL0S2+tKL3biDnbKpdTclTJ4DLqgV1EXimAxGf6tLy8VNZ1LKk2wvNbK1wuU1FrtwTXCu9kj86ITvB7bV2Nq4nRShO+5VbQk2WHZYnTZ/JDE94f/XVoTlvgK/Ftv0euf38TBr1cMNRYFQ4bs3s/1fZyYF3IhUGnR3R0Su1uazxIhfUpgkSg/yBEw6s4eI71AceRV/o3zaXIoG46/vK0fXLKf+SQFv7Vm+dOTre9RXGYtJGQLtq3EWx0zzX9WrElfGzjjA2im7EchelVJz+FfgpDtspRh9CcKc6dq/jPWOk7+IAM4dwJqOXevjMsSPJXXDiO/b43wbc54Y5rMlNRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZoI9SRDtvJSDvOZ/2ipyGwTFwETg9VeDLOTcWTkvHw=;
 b=LfmeWECcCU0GvvYURcc/ZdhwjTWru/Z6WxIgvkc2B3EaL3hCmuj04JJmxedrPrLTeV4t3gMz8n0PM9UkLKSEEBXRyi79mAsACoeIr/PrRrk1QaldnYyAjrdBD6ugmRT278t/b8cKo/8CeZIU+OEUWc5KGatPvpOe/Itwzc/2NlC4ry0lgcxJrWZXwvJEP/AUcdDaJtUDfoXQNsRSCvZO1IlLL8gSXTOF+P+10uFj5jhT2Hnzfm7nwdIssmpMWIhs+QU4s7lYL4YvnO9KUrRarQLyfFuyRovELPP/gxcqBY/OkGycdV7ji3slDBoLolPJhQUEl1ySM+qeFhUZp2e/xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.33; Tue, 16 May 2023 21:13:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 21:13:15 +0000
Date:   Tue, 16 May 2023 14:13:12 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v5 06/14] cxl: Store the access coordinates for the
 generic ports
Message-ID: <6463f1e8d963d_250e2942a@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168357873843.2756219.5839806150467356492.stgit@djiang5-mobl3>
 <168357884996.2756219.11067819935569345137.stgit@djiang5-mobl3>
 <20230512155957.00000c2f@Huawei.com>
 <4f398988-e5fa-cbc8-f73a-bfefaf89e252@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4f398988-e5fa-cbc8-f73a-bfefaf89e252@intel.com>
X-ClientProxiedBy: SJ0PR03CA0146.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS7PR11MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: d152d60f-1460-4482-bd7f-08db56525ce3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjohN1c0dKqH3YQ+kZwYFLcH69RBvB08o52ifVMnT1RvJouT7Vb7NQd11iume0lYRAPMUpOijk6x9DZFFph02XdsjDrg1DKNvoM+PTgkqpNG3S51MatP5KBMiTBqvB3Mdk14XUUP42Fr2plZTGWuKuS+FLLuKXzoVAqP6dK10x/hjCXUrBoJwHMyJufYco16qCp1qbe1YqyiGjSQbI9rJrR1e1ybnR8iY2OAl3y0cOXBnZenXLkXtL+DMbemuQOrP7wdH57NFJAtDaQoeJIpXxSrlCBJXFr2eQIzl3IMFjrLC1QaV9v/EU4QyGmrRwjBVeIYDtUp6mVocmaeRsI3sUKwEhxq8Vifo6B7eJuav9ZZsSLGS617KBKCeWLunj9yE46BRQaFpsIwXTjzAYgCW7A+W5CanX+OQ/vxkZWXXyVfrTczP95bQ4uRo4Kw8y9r5+pyivFVbsR7HOKLzmozHZtD/NQfjK3MmtnsnxhYxvwJvgmOHH9ptI/pi8JDSIZbHtJFRCtUq5XqFZeTqUWYT8Ocn5MBhPOp/XBMID+E5qSKleZkSlsDI+jqGUEODFvV7CSERz1UXgXc6JvaHw1vU//n3+l92a8Y89MCunPp0es=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199021)(6486002)(4326008)(66556008)(66476007)(66946007)(478600001)(86362001)(316002)(110136005)(83380400001)(9686003)(6506007)(186003)(107886003)(26005)(6512007)(53546011)(8676002)(41300700001)(5660300002)(2906002)(8936002)(6666004)(82960400001)(38100700002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xg9wKye3YJmz118j9KsJJra0IMGrspCnsLkEQRZlewF0hLlUNFBNuazvQXZT?=
 =?us-ascii?Q?TmwF6UIWA2Fe16y2Ibv8xaJp6fLnz0RkmRyb5T6sageU60dqH6YXrBXETOal?=
 =?us-ascii?Q?6GIFBhGqCcaSak0yEXlWVEWlx27uuz7zFbJECLefw36/3VyNFWZ1APtLut7/?=
 =?us-ascii?Q?YyfRfyfSgN2lMjW5A5wWUJzeTpHsdQ2OnatkKBhKsaZ9ESKZA7y4eAkvvTqs?=
 =?us-ascii?Q?YrTgJc455tl/E6v5nwxqJ9iQCfaxYCt7fiW0ADBqxdXUY5dg6Wkm+V0fCCPX?=
 =?us-ascii?Q?CEV2Al85ULXEkrHc0fn/lcz+8ac/g2YThKconeHx+Y3wzNA2crlrRB6tldMW?=
 =?us-ascii?Q?LFUKE6oxLKgS9imkVy/hVneS4hLuTC9muNPiPKkso9S+oj8PEiW29N52YqnS?=
 =?us-ascii?Q?BvmcJANSWU9Ijlzxi+m5YutLdF5/CiFenPIJaMk2ruhtRohLTywkDdHa9JdX?=
 =?us-ascii?Q?+VeI2JSr+1NSCkdHbgTyrw+3jNpB6iqSRVaWg0oP4uMyObNSK0hPKUDO4Xtw?=
 =?us-ascii?Q?LsFzRizYt43vb5JYNTozpupK+HnmnlxL8SRJp1Zli75bVIsuGL0wJVlp0BnH?=
 =?us-ascii?Q?QF28IPyr65BX4vhPMMh5VsTfYYqldLYRqhUquigT7Xk0v+g51fRf7Q8Yjk0W?=
 =?us-ascii?Q?U0CX8JZFgQkGElHiZbXCd2G4tuVMMvxFHuiI60y99Trtryk7SCx3UudSbQsE?=
 =?us-ascii?Q?90hT9HhuIevzOuH/zlfdDyP2Y7GBoObr3CGmkjWWrtq+hFi9l/I2OSG7cNdQ?=
 =?us-ascii?Q?Gujw+Jxp3pWo9HzdxQWz+D5B3hpgdzyfKZjRsjdTYBGuV2lLkhEdowbxQIXb?=
 =?us-ascii?Q?L6huflRc++Doil5yqbylL2m9GUXvzSx9U+MiWo8d6KPP7o7x6T7wyBkFPbrH?=
 =?us-ascii?Q?jBsNrzbWGNkPBZXtfRUTvFeF2dILeOvgjsoZIyI5UyVdvimUTHb34QChkC41?=
 =?us-ascii?Q?mlHBKpNTS8kUKGH5y+TmMp1U478qJmBRUhih5f2B+JFwwNiex9NDRC/VvWDV?=
 =?us-ascii?Q?zVFdqu3KhA4uCG04JaQwPZFxzJgIXWH6+da/sSy47O+EngAx5LLPpYwPJrQc?=
 =?us-ascii?Q?K3UpAJNrB0U+uzdOqjZZlDJ+VTDBLKb97vco25K7FBBy+DjCdnMXE1ClixiD?=
 =?us-ascii?Q?cQ9vvNOK2+UuqsqNjEN3pmiuYAmQgL6i+J7b/KG2nxQ4Qb6q6Hg7btabpBFR?=
 =?us-ascii?Q?mW/yHtBGVxiVXTQ04CDenz7TzF+3GxUHMJDNy6/bUbKx2HWxOEM9onaTH4Ox?=
 =?us-ascii?Q?PsjbPUqr/QE75nR8R597piaPr97AoKKIBiwIrDSm2HubTl29w4ozrR5HmZoA?=
 =?us-ascii?Q?pzmfTs9hgjaH1hpByvYVp3hCBM36FgQ7120hks0Q+UK1TLEp53AGjDayzhQj?=
 =?us-ascii?Q?BUxdhe4eq4l+gFBksNMftiBnPt4dbWpaTAnhJhGWyJZjQtf6h0C4p4a4hFbW?=
 =?us-ascii?Q?Cygf2hqc43KdlUABhI5MIbCNxb3M2ZGy7yhJR2E6qwMjEKv6zJCEYgg2K5oC?=
 =?us-ascii?Q?MSSESyUw8ekjk+V1t8iThy+WjMZ9HWNYNmOArcY3uVJ+HTFvPguRxqKlXHA3?=
 =?us-ascii?Q?monYiwIHNpv+rv6AaRSJGjSZdu5hBjiKijDhnfBybMkWhCJnSnRtFMkq+/2I?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d152d60f-1460-4482-bd7f-08db56525ce3
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 21:13:15.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUtDTnqroZ6FPaxSjqGNUTYagDg+7GYeMm87V8FXRxrFY6giR6d1YP7fSm+x/P5k0ozRdvM4Gxuqerqb7WvALlpm14yVJY+HqLcrbwzu080=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5990
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 5/12/23 7:59 AM, Jonathan Cameron wrote:
> > On Mon, 08 May 2023 13:47:29 -0700
> > Dave Jiang <dave.jiang@intel.com> wrote:
> > 
> >> Each CXL host bridge is represented by an ACPI0016 device. A generic port
> >> device handle that is an ACPI device is represented by a string of
> >> ACPI0016 device HID and UID. Create a device handle from the ACPI device
> >> and retrieve the access coordinates from the stored memory targets. The
> >> access coordinates are stored under the cxl_dport that is associated with
> >> the CXL host bridge.
> >>
> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> ---
> >>   drivers/cxl/acpi.c |   28 ++++++++++++++++++++++++++++
> >>   drivers/cxl/cxl.h  |    2 ++
> >>   2 files changed, 30 insertions(+)
> >>
> >> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> >> index f9b35e8fe810..675a4f423f4b 100644
> >> --- a/drivers/cxl/acpi.c
> >> +++ b/drivers/cxl/acpi.c
> >> @@ -537,8 +537,26 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
> >>   	return 0;
> >>   }
> >>   
> >> +static int get_genport_coordinates(struct device *dev, struct cxl_dport *dport)
> >> +{
> >> +	struct acpi_device *hb = to_cxl_host_bridge(NULL, dev);
> >> +	u8 handle[ACPI_SRAT_DEVICE_HANDLE_SIZE] = { 0 };
> >> +	int rc;
> >> +
> >> +	/* ACPI spec 6.5 tABLE 5.65 */
> > 
> > tABLE?
> 
> ooops caps lock
> 
> > 
> >> +	memcpy(handle, acpi_device_hid(hb), 8);
> >> +	memcpy(&handle[8], acpi_device_uid(hb), 4);
> >> +
> >> +	rc = acpi_get_genport_coordinates(handle, dport->genport_coord);
> >> +	if (rc)
> >> +		return rc;
> >> +
> >> +	return 0;
> >> +}
> >> +
> >>   static int add_host_bridge_dport(struct device *match, void *arg)
> >>   {
> >> +	int ret;
> >>   	acpi_status rc;
> >>   	struct device *bridge;
> >>   	unsigned long long uid;
> >> @@ -594,6 +612,16 @@ static int add_host_bridge_dport(struct device *match, void *arg)
> >>   	if (IS_ERR(dport))
> >>   		return PTR_ERR(dport);
> >>   
> >> +	dport->genport_coord = devm_kzalloc(dport->dport,

This needs to be the same device as was used to allocate @dport, and
that's not @dport->dport.

> >> +					    sizeof(*dport->genport_coord),
> >> +					    GFP_KERNEL);
> > 
> > It's pretty small - worth allocating separately?
> > 
> > Maybe add something on why to the patch description if there is another reason
> > for this dance.
> 
> My intention was to allow detection of whether the data exists or not 
> based on if the ptr is NULL. I'll add explanation in patch description.

A couple reactions, is a "zero" access coordinate not sufficient for
that?

Also, "genport" is an ACPI-ism and I was aiming for cxl-core objects
like cxl_dport to remain platform implementation independent. The
concept of a dport having a host-bridge access_coordinate is generic
though, so I would just rename this to "hb_access" or some other
host-bridge generic naming.
