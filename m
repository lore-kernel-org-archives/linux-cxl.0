Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056737883D;
	Tue, 25 Aug 2026 10:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654061; cv=fail; b=d1REpQWpj9lzn25fVYmrZBGfPNZpgXe+GuFGk3etMIe/gS2688V3oWpEUVnKXHNdP0tsXNpp60xViz3ZGw+XlLNZXEMIP6V/b9vkSYqydlgMF/QE3M3bMIfYrtctrV+cRfIYf+0cdvk2f+PLwwM9OC4f/jAxTEn/FvFdCKAxgkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654061; c=relaxed/simple;
	bh=UB+A+U4pI6wvK9Pf/wsgv8EjseqZhPTvXnyBJ7KCHxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kG7nwhKmrcxMxVAonEsD9pGAHIsB5Rl0wuExlbyw0/HFjsCljd8edAceV3+FBMOGEdXHuBWfZVxdkRu7TcfBozJHUZsmp7Nkuo3npRMAG3MzneQnp9IaczL7nJPwx/54JJJXthYSZMsalTQZJ8jeDAeWLuc4nZkE3xclDeuCSeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cO11mW3E; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cO11mW3E"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rtr3YSA0eFaUoXei1kNjIV0iobfKF1ukdzdQ1xfLoAqCCD5sbde9mmSkME3VG486t9GbjZ5+WQtFkeZGqwb/6AxvJUfEBe/TfhmwpDH0x7yl0DzoKRWsdV4m4Qx/DJQYrnuyyntEIz90mpytv7U6yKqYpZ5ZLsi+UFZBa66jA7afzZsCYRPRIq7Z4//bK0nrpuE+1Bma+OrgTYXtW3xy7nBzZlBQPBqiL10v/EM6Sz/jR1PA1RNMdKxSZ64aziCHOGf8GJUsIYG4M1Jxc///oCje7YKACeGHMYniTtABg/08RK7cnscKkDrXgeNhKIf7njwZWBo0aGru4VDehgoHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKUhIPn92jilg9oEHqYLd87u3PnqAh8TDGDnO756UTs=;
 b=GIv4nz2jzZKCINeJVLHGwzj24MWkAbJdnk9dGHo4SJZY6bqiL/MgMt21I9K/x39BP10hlCUT26JCygZmjs2zhzRGELUThrgtKLNy/ou2KSWjCi+ieewDeZRGbkWmGbwNP+lPrEB4PiNgw7chs7NKsYo63D0LyZQdOE5Jq7NA0ErpUs/37/rvaBwup9bDVK4nnyE+uCaFFN3DzJQ1M9rzhx5OoCs/wtLCEqRxuGUeZfji6sQ7Qd1QEwlb/H6gIPaTeE5tQ3BcSzaP+b12E/Ha62jBrAJqhIQg2wHRv6o73/yp/gKluHzezrkZyMhclmcVPiXBhF2Oc+hoT8lajuXLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKUhIPn92jilg9oEHqYLd87u3PnqAh8TDGDnO756UTs=;
 b=cO11mW3EtrlSaHfJ8qxiRKp4kEvtxdMxdX+YNCavUIrm41D5w+dNJcNKGI1H9MogI/hYQsiU2IA0mRNIWFP7R/l+yT71sA1U2Bh8ZbxX1ktFqLL43rQ4qmXUCfudgxEoK2TGI5y/d75QPjA5pm6Irvs27UFHBkmElBse4RvWue3EI0Y6NVt57XsSlqOcWqzPvBKpO/XIGTwN7d2eGMylHEApk8bz3E/CAYsaM4QiLtH7Eav4o9WnU1cIC6AUWodEwN4fhRziQuiDpTyIpm929V43yoG+8AQVnX+eLb0vJR/XFReGL70TbK8pIZrLTSavmvbfkNaF/J2yEU3UN09v8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH8PR12MB6697.namprd12.prod.outlook.com (2603:10b6:510:1cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 10:34:13 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 10:34:13 +0000
Date: Tue, 25 Aug 2026 18:34:07 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net, 
	rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Subject: Re: [PATCH v5 7/7] cxl/fwctl: Propagate feature RPC delivery errors
Message-ID: <ao1vXM02zWOjRIrj@MWDK4CY14F>
References: <20260813034538.13189-1-icheng@nvidia.com>
 <20260813034538.13189-8-icheng@nvidia.com>
 <b0741acd-327d-43ce-94d8-8f06730e2430@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0741acd-327d-43ce-94d8-8f06730e2430@intel.com>
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH8PR12MB6697:EE_
X-MS-Office365-Filtering-Correlation-Id: d417a1ed-86e6-4490-30cd-08df029467d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|10067099003|56012099006|4143699003|11063799006|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aU89tXt9djjh6skmsjSozwawZj3OtyPQ0hlp+Z9RjMnIwgkdNl14I9mrDsRVL0cPdoitupSujNv5IH7nMWfBRtp+TFTIUKSAQvMcRWV4HxE7mBGwzXYPLVESHM0oEO3yllUlCbkZzhnVlsMdXD/m9RFZKG8e36gLW/WUkCdBgzOFlwLC8pk2Y2YZeuRyzgG9hN1OpHIMSVtORngOopcHkIcnVYfpjJSVqZxMszSIm3oJwbpKAzliBr8KV1ApgdVKT4+ENnbgxwgQZQJ/yDBIWz84McBKBS3tjCWbtzpSUSK4u7n+vQeG9MW6YvKhqRlQPySaUOcWPPs/6Ujcy4jEvledKrtS/eyfhhX23q8ICklT1CX5k2fe6w5BCfE7bZ/PM1QE9sYfBOAb4U9VbA4kMLeiN5J6Tg42eiEs1yBjF/J7Vo8kO/Nu6ghj0HopF4IR1iA1N+J9gplIhvXHftcNEbGyTZHovD+XSDqRbijUITxpmLQWyfxPSwYhKLq8AYgsY1vDkoSARrBN53tZ7VJkKgilWobYi6PO7XW2+BQzuXPyNZ3gMGnR/E/S2Oc5uAIFRg7f/34EN9qj0FpMX2kGw2yZEkLGRacPZ6JOEyTr7cm+m74wM0FRl9D6j7IZ/wZDBYTNJP1lJCDIb4rZzp1fEBCo3ku7QBCWEfKcgTuGZ88=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(4143699003)(11063799006)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HI1xhhKjXSLR4nCrKzYMI2xWZRJajv5QQGdsAYZJ+Wu1Ul8Uk9n5iHWyOrbO?=
 =?us-ascii?Q?pawm1THtAwaYXaqU4KB5k2eptvQX4y+949bafoXceMAWb5CAR5asre99/EQ3?=
 =?us-ascii?Q?PAyNSc0tZn93oI1VCYV2MoMCWc9HGxtWDmZp7m14XA4TnfKKaJOuzf7CATHc?=
 =?us-ascii?Q?jErcLoEcdc91PlseleGgG1xzdsY2xz2mH6aorNjjHVm7/mTUyPOA7gVf8QiY?=
 =?us-ascii?Q?3PtC85qHYMjjBoot5LEPEWoqMTRBrzhuAS48/glzM6jxEIrwCueTGlRY+b6s?=
 =?us-ascii?Q?4fsfbn52pToOjQPH5ymzWfnfX2rfZWds4en0+7EJoYg5AzoMB2qnbyfgYG+r?=
 =?us-ascii?Q?gZ2Q60gB03EB2LFCfKi5rG1T8TKctj/ZXKXexkyvWqP0m0bXHTfpTprcYIBI?=
 =?us-ascii?Q?JGMAJp6eIFcgoqIbIJLojOpVwBftv0lrrzshRHH3YxKNnAkHhNefU+866qRU?=
 =?us-ascii?Q?p48sVLu3uRJFmn1V8V1mbyq1HGj5251/5JuIX0jdBRIBVvkfcn4yT8BnjAqh?=
 =?us-ascii?Q?jDTbSF/PqllFEHvEKx8VbOiTa1lg94XMlBEPWxSpCqw8KsbLs5ub9PSJfOl4?=
 =?us-ascii?Q?dlSEdkWke/Mda5dzmUPacvYQ5jnyD2Newj1URDTDQRcI4E6NJAnn2zr2fTFn?=
 =?us-ascii?Q?akef3c2Mlt00BSg4nwSvfBfDrmug98zfKY+oyOmO+Gwgyee/1BZeE7KbLI+P?=
 =?us-ascii?Q?LTBc6WcIDjBe83drZBPrbWFIoSRsV8ikuWOBQOLPza6nJFJ/J+YI1VyrYhWM?=
 =?us-ascii?Q?RwZ6s3pvHfoIdVqLy8rsAouXxrgxG58fLq8E9fu/PFjmjSChQv3Grd/0hWpE?=
 =?us-ascii?Q?mp5qni0WMDmE82dlTFvJ9F04JMANYW4fZANtfUQzh/pSleXKpQK2AuQbIW3Y?=
 =?us-ascii?Q?Tukkit6j8C7SBZ+j3pGszoVlGvoairSFdyRivpNNXD3hIWccWQfFuSSr/8sI?=
 =?us-ascii?Q?ca3bSR4PxSjq9jtsKA5Oiwys7jvooMYaxe48bzN2qTs7g4MLBWfZo/M89YiU?=
 =?us-ascii?Q?RlHn4vTrKuKMZK4HFISuj2dekxjRDUZrVJ7wfeANIR5UYsKe1KtBt/C7Ki46?=
 =?us-ascii?Q?nDIZS1GVCXG5NSOCoWOnIReqQRbAbK+f8aPsBSb/0HKTDABGJbQNSm+30jvb?=
 =?us-ascii?Q?ER3gJdhbSOW3TN/hCrV9T+GJF7wNw5cADevlIz1pDH0PZXrz8PtaRPET4FB1?=
 =?us-ascii?Q?FhSFF5QcWMJM9J3IBDcyEKq80GaxklUjYPisGLtxOzyJdhBYTuCpfxES3gk8?=
 =?us-ascii?Q?eB4PnDZMG30/jbaNA9GXU+iQtxVil9smx/dJ8cwfJUSWWmwl0U8DuyGZXcAA?=
 =?us-ascii?Q?0OEm5gaXJ3Pb7Y9IRxuPeqX/lidvhcikuUm0lM+M5Eaip/EAvJoP+HaZw//6?=
 =?us-ascii?Q?PLBw26sipmmzRvWnZh1WwEzaS1LczDwh6r5OvRjIM+wtD8WXmrAqGIwKl4lz?=
 =?us-ascii?Q?2lgPSLUAZOrD8tKukofHx0RQIeNqsfFbKnp/LbO6Z29evux6iSguR3t+1ERE?=
 =?us-ascii?Q?Hc6IsXLWTnvFjmPI5rTsTsfceNUNybGrsoUGipV2oQgYtk1h/r1Lm46rt6Ju?=
 =?us-ascii?Q?u4uqEKkL85xzW5rgG8jhkGgpqoH41nDt6+yDfaHJQj/sMJ1v6+SK1B7XGAGB?=
 =?us-ascii?Q?GzmGljQ28bNHXM1U9yftE39X02WFd2pHuLWKU3g3MQ0d77T34VQrdq4sc6qi?=
 =?us-ascii?Q?GTjR9L8SHeoHbn1DTvhokJN1OGFGh0/H8wltrSVP7HmhVfO7+tlFfy1Z0sGg?=
 =?us-ascii?Q?MP/ny547eg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d417a1ed-86e6-4490-30cd-08df029467d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 10:34:13.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zp/p4E4MKJYDo8/EGEsQl897xR3Z0Hvo1hiJk0sOZ+SVCn5Cjz3v35iigySrmhJBXEJlCmmMUfvPmCSPtsa3hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6697

On Tue, Aug 18, 2026 at 04:51:56PM +0800, Dave Jiang wrote:
> 
> 
> On 8/12/26 8:45 PM, Richard Cheng wrote:
> > FWCTL_RPC requires delivery failures to be returned as ioctl errors,
> > while device errors are reported in the output. Get and Set Feature
> > instead converted all failures into normal responses, sometimes with a
> > SUCCESS device status.
> > 
> > Initialize the return code to SUCCESS. When the helper fails without a
> > device error code, return its errno. Continue reporting actual device
> > errors through rpc_out->retval.
> > 
> > Fixes: 5908f3ed6dc2 ("cxl: Add support to handle user feature commands for get feature")
> > Fixes: eb5dfcb9e36d ("cxl: Add support to handle user feature commands for set feature")
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > ---
> >  drivers/cxl/core/features.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 8d44ce829497..30e00faaf3a9 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -232,7 +232,7 @@ ssize_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >  	int rc;
> >  
> >  	if (return_code)
> > -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> > +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> 
> With "success" set here, should we drop setting of *return_code at the end of function since it's no longer necessary?
>

Hi Dave,

Thanks for pointing this out.
Yes, I think those assignments are redundant after init return_code to
CXL_MBOX_CMD_RC_SUCCESS.
I'll remove both in v6, thanks.

Best regards,
Richard Cheng.
 
> >  
> >  	if (!feat_out || !feat_out_size)
> >  		return -EINVAL;
> > @@ -289,7 +289,7 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> >  	size_t hdr_size;
> >  
> >  	if (return_code)
> > -		*return_code = CXL_MBOX_CMD_RC_INPUT;
> > +		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
> 
> I think similar for this function as the previous comment?
> 
> DJ
> 
> >  
> >  	if (feat_data_size > U16_MAX - offset)
> >  		return -EINVAL;
> > @@ -492,6 +492,9 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> >  	data_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> >  				    feat_in->selection, rpc_out->payload,
> >  				    count, offset, &return_code);
> > +	if (data_size < 0 &&
> > +	    return_code == CXL_MBOX_CMD_RC_SUCCESS)
> > +		return ERR_PTR(data_size);
> >  	*out_len = sizeof(struct fwctl_rpc_cxl_out);
> >  	if (data_size <= 0) {
> >  		rpc_out->size = 0;
> > @@ -544,6 +547,8 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
> >  	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
> >  			     feat_in->version, feat_in->feat_data,
> >  			     data_size, flags, offset, &return_code);
> > +	if (rc && return_code == CXL_MBOX_CMD_RC_SUCCESS)
> > +		return ERR_PTR(rc);
> >  	*out_len = sizeof(*rpc_out);
> >  	if (rc) {
> >  		rpc_out->retval = return_code;
> 
