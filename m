Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854F81FC9
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 03:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M/xZsh+c"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28AA3
	for <linux-cxl@vger.kernel.org>; Sun,  8 Oct 2023 20:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696823496; x=1728359496;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=Nv9S1BsiltsYA4JsS7iFmXs+4NOSErBybvSDLbPXcZQ=;
  b=M/xZsh+cAOz7ohUNpWKfWT2YivJBfIPOwPj0U+FjTaGfrqItQLqb/PMp
   XIE74rJsu7FtrcRqK+bwCx3Tzjj185SgBVXcpbsalIG4JSc3WWUFFiuLp
   2JPO6ew9IwvVE5kdaQMIxlv7UAEe8M41jQFA2WS4fg/jwgb5Y5vMIvYsk
   GKdL5XWIwv92YMIqhK9dlPI4MPMyy44AOmfZ5pcikLlEEws8lUKqZQCuK
   0wAiwlIzJrUL1goXFSXmcJWBpI11T3TkpeyuHXXAcaEyOSnaj2JSZaim+
   q5rtnZ1BHUP8WiqeE7BoALCGF2/tQJyXMot1m7aC3vg42KUil6P42rZ0K
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="363419705"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="363419705"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 20:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="702749833"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="702749833"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2023 20:51:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:51:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 20:51:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 20:51:34 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 20:51:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GiuauV45uiSzKfO9cfkWr0IjT0womIM43yw2H+8jbmxXjrWrYOuBmNE+mGrOAy8FDSyGd37HrCCKAnId0TwKgNGRyY9u0qmzmS2ZDCRjqHOPrEBbWmV5/EsQIITw8aYvdYEN0w3+5WfDIwmtMMC7uJ5jr29J+EeMFxTMEKZ5p9H7TWLRGcQfUvklsl8WOiDZZoq4RVOMtZmNcegNVNQkLij+HIs5c9u8nH01X1Y6Eonq3KMFqJmpDmuLTuE/7mBuZH1pDOIYXRiVJnB52TlRiH4O8v1Q8YC9JuHwAZRkYkYVG2ILi6O+8evJ2RJSDiD4NbVlc1oboJyQx37PrRBbTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhnNXUhrB4V1XhCbLsXK4FdXjBF/vicyco7CumIrm/c=;
 b=hmeoPAhvbG3raO8G1l3N9P74hUUm7ZAsC7YQqpWLS9gw0KYrvGk+DkAoB2s+tnEIAQ8BLyQW2tXY/IPn+zvSw234/x9quA7vA8enTTaHxT8zFsMdCtCpQj+Pf3OGtticoFma8y/npyx3RtBl1EUtw/ONcQPEEQeEVdSElkpDsJfqbH8qZCLm/+nxkzPIbAYRHuoh16STTp9bAcHi6JxXBNld0JlXgvuFv9t3sEcCfFjXn0iCvxLLIJ5ZJUSpcazOtHFy+xxb1PtQLXHxvusICeFehVG5av8vwJaCpReYAb1Rk/5c6TfAFaDDZaQVwxEI2vXYMHUpxyJD5sRQ/ux8fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 03:51:06 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::c5a0:a0ec:2d4:995e%4]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 03:51:06 +0000
Date: Sun, 8 Oct 2023 20:50:57 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] cxl/pci: Clarify devm host for memdev relative
 setup
Message-ID: <652378a1aa4a0_1d98842941c@iweiny-mobl.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <169657718805.1491153.2457900463470349092.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM6PR11MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: 010165a1-baa7-471a-0d8d-08dbc87af721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gr+iiHV/X4ilwPmrubVQ5F8TnoqtpQbkTN0faFBXTSIIqJWo6Etgsnwy72xUqHYB0bltaqJLCryXq6b+taY+ro0S+cfRNlZZomR9VWKhaVwidhr3mkLpKO8fETJz9pOUJ54IGLeYN+f/BH5KNyeLPusHAuVK7N/CaRDmIMbQzUUVZ5adO37xWTzxzcjbRDj7stPSMc6o+4w7K3NCv48n3La3DbnYCU+3hOtj/Vy6/YR7wF+CdcwUyO3zSq7YJfDuO+YtGAmdVb4C7FRnsC9t3noVUbtgGGB6C5KoeTOHVjrJf55fItPL/QXBqHrt7bWcIN0scQPVF//NkPcB03Flw+JaLU8Zk4iyEKmcdqCB/2EQnO06KBdza/OobBFx02DnJnELpNA/k4B9GrIo++rwrLelG64+GuhKSbdrGL9/hI92gzE7L8mqpL0kDuHRNH/mp3Ffxa/RLq+PhMkwwfur1SGni585XTXpApdgCOOhBdz5iXhjfQzD0JY9oVsDmGrWX9uype7BZrh8irZ9CecDcnA1b3Wy4vSv0F4FcUWSx+h9QjC3GBGv6baaYLdAa+1x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38100700002)(82960400001)(86362001)(2906002)(9686003)(6512007)(6486002)(478600001)(5660300002)(41300700001)(8936002)(8676002)(6666004)(44832011)(83380400001)(6506007)(66556008)(66476007)(66946007)(316002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OckhUUnKpd6uppoLFFRzkfRLbMQFuzVIkwg02ytcnLej4w1vcU1rxy4E9iNp?=
 =?us-ascii?Q?DISp3/9QXG5J/Ju9g2buEC1DUepaVz9A9FBImWKK6Z7hpF0btjq6r2tTmds+?=
 =?us-ascii?Q?WkBTlvQ81GzxVW+NYn7m7Bs7rsjo5ieU1MkC2L34GHA3CYwnihPZlNNp3kC1?=
 =?us-ascii?Q?57D++3/ly1hZVDDFm1RPQVN2hzJlNJc36wpHxMi9ZPne8muftcrSTl2dJmZm?=
 =?us-ascii?Q?3xlYxogRsbDcLheAtuGhlcWrrIjs96g+CF4G7Od3R9HGTu1KqT/AtEmBTaP9?=
 =?us-ascii?Q?Df89iapv4ZxAsuQPBBJvPafcc8VeFIHojHYI7WtvF4LXZio05EJ8sndeG7IF?=
 =?us-ascii?Q?6qTtAHJdrsNaqNBY3AZEZIrXGSEbW1NDYaFUJ35FEEJPbC0gq1c4u7rtS3Ck?=
 =?us-ascii?Q?n+ZsZjQw+VKsQUtQEgwuOzaFN8hgEWyc/3pbnG/C57lf3qGnHANwIugTk8YW?=
 =?us-ascii?Q?PVW/UttzQG/nLqmyUGw1gjFH6Gd1z7wnD6UFG4Uz00AFixcbgGIMm8P0Qr7i?=
 =?us-ascii?Q?99FRpnWNdYYIBlgS3k8jY+oRbgAzUaak+d5GjukZ/lA7kO37GqxVJ6pR+gH1?=
 =?us-ascii?Q?iTSoXVCvDlYmWT644Ghz6muVEL735J9iFM6lRkqt+mTxmJ4FTl92vqDxDnF+?=
 =?us-ascii?Q?DmkuQCmBAlUf0AIX9ob23eTCWBFp7a1TXpUwc8/e0kzHMqoiufT5PnRo44Ex?=
 =?us-ascii?Q?/2msSSvX/7aJbxUP06guxdUMGaFVrZ9I7wXqw1+wWLmwdDar2FVeNTC+JeoL?=
 =?us-ascii?Q?sWNavaMIXejLu88oGXRepyVNtasNvMMA3x+E85wMHAam5YWTZAAx2DFZd/Jz?=
 =?us-ascii?Q?iGXth1W/m2glz3QojKGv09Kg2c/wJczdk0lTkUN1J6sSA7XI0AMBDnwMpmxN?=
 =?us-ascii?Q?PJq/6gmU1kJpsWqz1uNzVTsQi03ZNn17P91uU9dm3bpwxxnJOhlLCpxMFd3V?=
 =?us-ascii?Q?GGK0T842P52s5kGPfpHbWmgkWGgudAvntSgrf/5QSXhXFBQsgjeags/pmZ2G?=
 =?us-ascii?Q?aNlyOArIy8CMo84GNHiL8pyzR2vz+ix6auRBoCrQB+vGnCPRVg35UWPG/vHW?=
 =?us-ascii?Q?fLUBaUMRif1hBBkbYhJoYUg765CGH3l6w9KY3dw9rW7NxxoqpXxcu1H9otTI?=
 =?us-ascii?Q?xXo4Lg4TmY8RdkbnS8dCs2zkzGTo7jEGPC0DDgZ7DgRv3vxVJA2J4F7b4MpS?=
 =?us-ascii?Q?zv/auoks+6wfnHtkEWlAhd2BSa39Icgmi7kY51DEuWK/d3IEjgXgLOeWlF/G?=
 =?us-ascii?Q?mlam4+cU6R/TlXav1s+72IahkjMVF7selkd2Ms1LULd/+zTQp7ntN4sIt4TJ?=
 =?us-ascii?Q?TvnQiGjvF7PH9rcSEL29Vpdc3O8FQifmicNO9pAqOdktkL5BRBLeSwAKh4eY?=
 =?us-ascii?Q?SyW7YrFpn2yT8LXe3Vr7Gg8x+JSXW/rwgr5+R/IBcPcIrrwguXKhB8zOLf2D?=
 =?us-ascii?Q?LAiL9foKDD2lGS9siVfDB0tYqrngCA3G8l+m+Fk5vvus2tENsDUjnGx5S6sI?=
 =?us-ascii?Q?8G6riI2Fib9Y72x+naaZ3QAVebClmFu6nPPTATRsdHJGjYIONlbXTmcYLlDM?=
 =?us-ascii?Q?Y7BTADGUyFx/Not1vB4w92Ad76u2Y7XQ0w/j1osO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 010165a1-baa7-471a-0d8d-08dbc87af721
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 03:51:06.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldUhk/Jp2ZYgjqbmb7O0aJBaZ/TCLoQq/kelMGw2mu+pZk8wFEtMgESyQQsofRPf3qK6Iddq7kybY5L4oXYnLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dan Williams wrote:
> It is all too easy to get confused about @dev usage in the CXL driver
> stack. Before adding a new cxl_pci_probe() setup operation that has a
> devm lifetime dependent on @cxlds->dev binding, but also references
> @cxlmd->dev, and prints messages, rework the devm_cxl_add_memdev() and
> cxl_memdev_setup_fw_upload() function signatures to make this
> distinction explicit. I.e. pass in the devm context as an @host argument
> rather than infer it from other objects.
> 
> This is in preparation for adding a devm_cxl_sanitize_setup_notifier().
> 
> Note the whitespace fixup near the change of the devm_cxl_add_memdev()
> signature. That uncaught typo originated in the patch that added
> cxl_memdev_security_init().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/memdev.c    |   16 ++++++++--------
>  drivers/cxl/cxlmem.h         |    5 +++--
>  drivers/cxl/pci.c            |    4 ++--
>  tools/testing/cxl/test/mem.c |    4 ++--
>  4 files changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 6efe4e2a2cf5..63353d990374 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -960,12 +960,12 @@ static const struct fw_upload_ops cxl_memdev_fw_ops = {
>          .cleanup = cxl_fw_cleanup,
>  };
>  
> -static void devm_cxl_remove_fw_upload(void *fwl)
> +static void cxl_remove_fw_upload(void *fwl)

Technically this drop of devm (and add to the setup call below) is not
covered in the cover letter.  However, I like it.


Reviewed-by: Ira Weiny <ira.weiny@intel.com>

>  {
>  	firmware_upload_unregister(fwl);
>  }
>  
> -int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
> +int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds)
>  {
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = &cxlds->cxlmd->dev;
> @@ -978,10 +978,9 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
>  				       &cxl_memdev_fw_ops, mds);
>  	if (IS_ERR(fwl))
>  		return PTR_ERR(fwl);
> -
> -	return devm_add_action_or_reset(cxlds->dev, devm_cxl_remove_fw_upload, fwl);
> +	return devm_add_action_or_reset(host, cxl_remove_fw_upload, fwl);
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_memdev_setup_fw_upload, CXL);
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_fw_upload, CXL);
>  
>  static const struct file_operations cxl_memdev_fops = {
>  	.owner = THIS_MODULE,
> @@ -1019,9 +1018,10 @@ static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
>  	}
>  
>  	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
> - }
> +}
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_memdev *cxlmd;
>  	struct device *dev;
> @@ -1053,7 +1053,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
> +	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
>  	if (rc)
>  		return ERR_PTR(rc);
>  	return cxlmd;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 55f00ad17a77..fdb2c8dd98d0 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -84,9 +84,10 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>  	return is_cxl_memdev(port->uport_dev);
>  }
>  
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
> +struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> +				       struct cxl_dev_state *cxlds);
>  struct cxl_memdev_state;
> -int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds);
> +int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			 resource_size_t base, resource_size_t len,
>  			 resource_size_t skipped);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index dc665b12be8f..7c117eb62750 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -867,11 +867,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	rc = cxl_memdev_setup_fw_upload(mds);
> +	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
>  	if (rc)
>  		return rc;
>  
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 464fc39ed277..68118c37f0b5 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1450,11 +1450,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>  	mdata->mes.mds = mds;
>  	cxl_mock_add_event_logs(&mdata->mes);
>  
> -	cxlmd = devm_cxl_add_memdev(cxlds);
> +	cxlmd = devm_cxl_add_memdev(&pdev->dev, cxlds);
>  	if (IS_ERR(cxlmd))
>  		return PTR_ERR(cxlmd);
>  
> -	rc = cxl_memdev_setup_fw_upload(mds);
> +	rc = devm_cxl_setup_fw_upload(&pdev->dev, mds);
>  	if (rc)
>  		return rc;
>  
> 
> 


