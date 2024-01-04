Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A22C690
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B7nZ3YUm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQDlMez+bz6QMTXgLzrJNIpMbLM00t/ImAibNy9cl2eAHqA6hywIqDGZ2q2lOSlV0kuTH2nikMpmdJGOxApVArgkFobN/i2135dPW5ZFHC++RVX8OkqKNSegCvr0YQsjjZM8c0v5aJ6e40NH/J/4Ql3fFG4cCaD4onpTizixQNmyboHGCg8FxHdWDWxQ8hRjI5TBFl4W7elpfHDFjU4GsCkxhfJnzm8KwLcBTJJ57EqDl447af4d0wo8fNKEQr9Cc8damFxCvGD2i6kIAOPyjTDziRcvp0eThEVG03KsV/3h8AzN2w833BBHflnSiqGxHzdAYlG9aAcxsvXBN+JUEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTY0jbovgRdUnKmmTshDukI/syG4Jc26FSDiWeXtpg4=;
 b=Vwx9JhjXnGiE5Qb66tk8LdwhjLs2VVPkNvi4UnogUhQbQ4VohHR/EDMX+g7+68XSgvu01UbE6G/RNyQFkaUcnHxr7u4iYT5BNoMC6+XDaGVbCIerMiv9gu0hFtBHeG0LFNiVYFKUOpHWBYMOaHhYmgvbysWzadxSIbWW0Fnx8vTLDhk2iyt26ltnQ2Gu2xDtlF0ETMn+doVbzDgojqNTpXcvHoOt60fdB62zUJ0IY6//ZyBA/cSp6XkSt6XSh0akhqStXz4SPqZDBuoV9mKJ54oalRb2uGqnmY6xtdXb5KTL+cJRVTroTUHNRvVpiViKjxtr/IvKEQyykX2N2IhLXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTY0jbovgRdUnKmmTshDukI/syG4Jc26FSDiWeXtpg4=;
 b=B7nZ3YUmtDVCa0Ip7J+aEu8y585zz04Ll+SvGfyFgDZfyYrI1QaTCx/CXRiH+itg+gLgR7dsdatghNGrpBB5jSEPcamPQpDEezWgcNFiJyQrpxqnngabP7ybZI6Cr6s6VLkHCD1KDS+qgAMTXPyooTFqpilclWf5mVuDMlv/358=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 18:22:44 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::5786:22a:27df:9a70%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 18:22:44 +0000
Date: Thu, 4 Jan 2024 19:22:38 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH] cxl: Clarify root_port cleanup routine for
 cxl_qos_class_verify()
Message-ID: <ZZb3bjsxYT2Rik9e@rric.localdomain>
References: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170438448564.3436708.17525645430052031684.stgit@djiang5-mobl3>
X-ClientProxiedBy: FR3P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::10) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: decdf56a-2bf6-40f9-aa74-08dc0d5224f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLB4NF1EjBQyoKdgmLuoh2Q1JqKHcJ+Yg+OVTI8in6ut/t+2cQ4uAgcVWsowMTgG06B4GxpA4lG+tqC8FXOpDaXepwtS0MRSsD4YLtdD62o0DyqJV6GZCH7Hd4mY1qlf3pIHTnl+Wlnkc6wBoSHbf+cRniDbZn1rrmqEfSTBAl4RT/Olf/tpaD7unyLnuFUWR8xoS3CfDoZ5/8HIOyC5XOYAYJhqkkbz4cKYT55OGVuII/q6jTlmDGwIbKdAGO+0W4xeX7H4gZeVA4+RQz2rr1Zi5woBbjzeu0sOvhh9w8DngT4pR3FNSF46qk4Dn3SoKywaUkOnFEsO9D5w+g/tPWf7dydcsk/Um+oZDL2kPdsatA5AJOTKTGCnwXuXBjcWTlvh7dvsmLRtx9It9G9lYBVbXG/VboTSsQHBnh5YHxSBt80gUEc1OPAnAawTBg5B/eWY13RqOgFTyP6U0YEIFOEW4Z50ttP6HpLxXGYwUuURtnSyAYQfyG6ufPlEPagu4kfmLJ6PxOYZ26Hui3QRJVIW30rNM2u55ooAzx9a5zpESqLgZcO01LHTotWDMiHz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(366004)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(41300700001)(83380400001)(5660300002)(38100700002)(6666004)(2906002)(316002)(8676002)(4326008)(8936002)(478600001)(9686003)(6506007)(66946007)(53546011)(66556008)(6916009)(66476007)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R/lw5eDQE5IG7CB50TLwcXObo8rKFDKYXzlEXVD5ThrYg7nJ3wxpv7cTJC5N?=
 =?us-ascii?Q?a/rkIip4+TMLE6sOccyfYrfVAfASYJxUW4GSKlTfHuQBG8NTP6HbirJU9sHo?=
 =?us-ascii?Q?pqSQcpwdbCClbDHCmmUXt7gyMKqfRKhU+03RuCdJi/e60os5qR7lLzmB0TB4?=
 =?us-ascii?Q?jIczgYZqtH2rY6tWsGF1RB7mQbJTmWYoK4NQZLLqXNIze42l9fs8F0/GEFhH?=
 =?us-ascii?Q?uFP2SmLnndSHYkwDqRh0PoVMZgGMmbKZDIIcAqHg89wsODYSbPf1rDZvH4mR?=
 =?us-ascii?Q?dO4bWiphmlVzFV2TiLGLK7tGIpk6otjPzFYwTJbmHkSuL2/eDKTSWsfYHWub?=
 =?us-ascii?Q?4TzCPfhKZJsBDOcanGAz0tUUjf6TpEMdj7O5ARM3dsvoI9+u4Xw95JAOGVUc?=
 =?us-ascii?Q?QY6vNQv2yXkrqUxUmP5f4J+RM9CKAYdggg5T0XRdrSx3KbFbObmuuI2R5wmS?=
 =?us-ascii?Q?QJJU+2WvwlQXJbqnz/XTklFyYW7w46aBtbcuB/xO0g/L7V3yMRk5cNnDuOTJ?=
 =?us-ascii?Q?mODzAXWDXavxxZ7fmC8atYq5L8cUymunKtSGH2F9IvBh5d9iZt+4qpBzD4Fx?=
 =?us-ascii?Q?1Z4Ey7U4sZmrEPFKA42SBtWXA1rUnUzUfZomBtWnqFAGGBwFf+Y+XK5BKcT4?=
 =?us-ascii?Q?zTRakLAM/MwxzXHLIlwE3tV3Nq0T6ARX9ifvSe8Crwt4FNiSjQHovm9gRqFu?=
 =?us-ascii?Q?EeXndaTnbfrXse3B+imhWop1Xog5V5LceeovmM2l9wpl8LGvk2PYODHPJbGE?=
 =?us-ascii?Q?AzX1ojtnzlZPb2kfbeuAGIZuUgnzIBqlPSZCT9ZzV+r6VJC58i8i4bkTT75d?=
 =?us-ascii?Q?ouhMJZ53aUFoePRUHVJXZ77q/PSxeD+VMDhJx7s37YtopCv7mlmNu69F6zRi?=
 =?us-ascii?Q?Oq/Jvv/cNTMorM/esWzrZpFebL9EHj+4dNI9x7i28R74Fb5zEwIA4fM9Vykc?=
 =?us-ascii?Q?pditofxg9W/Gxjkf00v6H297fd0/9NkfUkhYga+X9BZ5uKVy30OSmTA8bymY?=
 =?us-ascii?Q?gb2TvzT2aaYi2Nm494iXa9FnR7L3r6vwAxGVy0zJszS5Fm/3JkUgxSRS8wx0?=
 =?us-ascii?Q?nGuM4e+LXXwclfpUucbsENe6nmOA8/CHTdr4nA7dvLgju+aFyhzZ3W/1MsAz?=
 =?us-ascii?Q?TVGfEWCbn7frNfp8u7rSBegslEGSl8bGeXwCA/Tnx4ca8qXtMriGYpSVDeR5?=
 =?us-ascii?Q?Cl7EXF7ecQKj+o5q9wa4nsex2uwijvBSLaUbrDV3FFb/Mnq6Z2iE/SQ2DBTa?=
 =?us-ascii?Q?wDzwg4svx9JONUzO54zts0d8j5+3S/Zlgbm45+j1ht9OJIQ40QW1FloJBwl5?=
 =?us-ascii?Q?PSiSVTd2CBby7CGlFlqaFGtowxqsVEUckFfvXG+E4w/vJGfTe/rTzmqHEfXa?=
 =?us-ascii?Q?e/LU9fDIdCh2bNXt5vYNrBvS/faWo3o+YwQuux2HttT16jG6oVRZWU6ro9hF?=
 =?us-ascii?Q?3Qhlu5evtKZm/x/3z5vsecUIJBPCeFktxvnewClrhbqQgTNgmTjlEnWbJMIZ?=
 =?us-ascii?Q?KSvafXeTxaT2AWwMEhkY82086Faf3YNvHS6GbK4EzeqgL9QFrsJDqsG6V+4i?=
 =?us-ascii?Q?gfZLJuLYwPMm6L+qieoWZ90VP75TdYTlW3rS3Qop?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: decdf56a-2bf6-40f9-aa74-08dc0d5224f9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 18:22:44.0289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdtoBdyxFOoloff2LcFBrpfTKU5F8jPTw5vf92KnynGqEH9vYQ0SufJHDhR5LqqJJBuImXWbOdhq62F1S3OUKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

On 04.01.24 09:08:05, Dave Jiang wrote:
> The current __free() call for root_port in cxl_qos_class_verify() depends
> on 'struct device' to be the first member of 'struct cxl_port' and calls
> put_device() directly with the root_port pointer passed in. Add a helper
> function put_cxl_port() to handle the put_device() properly and avoid
> future issues if the 'struct device' member moves.
> 
> Suggested-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/cdat.c |   12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..d6e64570032f 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -345,11 +345,21 @@ static void discard_dpa_perf(struct list_head *list)
>  }
>  DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
>  
> +static void put_cxl_port(struct cxl_port *port)
> +{
> +	if (!port)
> +		return;
> +
> +	put_device(&port->dev);
> +}
> +
> +DEFINE_FREE(cxl_port, struct cxl_port *, put_cxl_port(_T))

Let's put this in parallel with find_cxl_root() to make it part of the
api for users of find_cxl_root() to cleanup.

Nit: remove the additional newline to have the same style for all uses
of DEFINE_FREE() in this file.

-Robert

> +
>  static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	struct cxl_port *root_port __free(put_device) = NULL;
> +	struct cxl_port *root_port __free(cxl_port) = NULL;
>  	LIST_HEAD(__discard);
>  	struct list_head *discard __free(dpa_perf) = &__discard;
>  	int rc;
> 
> 
