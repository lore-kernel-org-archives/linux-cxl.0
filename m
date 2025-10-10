Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94792944F
	for <linux-cxl@vger.kernel.org>; Fri, 10 Oct 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760132007; cv=fail; b=kN4iSE/S1OAGqEafkDZsIvs3GZYYbg9GzCjbrk8+sHBZVoZRC2fS1pSrj4gMRPXhubK6LB/CiZuzv7cxzi+vb8rbf+jo6eaJxcStfMOpLykjMSBc5BmryGbSubtH0uEWtFsL4kAY9s6BK6608PtyXADhmn6z/dkny8ud/QIXGno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760132007; c=relaxed/simple;
	bh=r7+mBx7CXwW+uIkSrlRff2fW4jwbYvsbZizdTzCUTTQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dFgCmxnEMJZJ9QFnNVe5/8Jma9qbqAFK1IGpQ978fOJuTwsblLnBQJJlI0fvvAL/yS4l/Exq6/Ho57p1LvypWLDow9I0LaQoI79hbQAYv6b1Y+l4tLaRreDpbPPAco9UUd9Gm0IPGd1RtGw5b3tP3AdKRaAtNaLiyZ6s8qLeG1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PbDTR9qp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PbDTR9qp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760132006; x=1791668006;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r7+mBx7CXwW+uIkSrlRff2fW4jwbYvsbZizdTzCUTTQ=;
  b=PbDTR9qpr9RSh1HalZ+gQuswo3aiIfV19veXebLspuiQd9rFg815otT6
   Y7sq3CmDAFmRrq+h8e8J5iOCvsVAjW+S06Kg+8RaiBrVbvcA4a6+hygQU
   qgzV1AkEns9zDKlf4YfNAgm18CQv89fkD0K5ZWI1i5IreF4F66z0nQg45
   dij7yLrqGfIT49r8qAr4j8FLsJmQzhjHYfjn2M9kFKz4HDN1lyBjtVQng
   dpghsrMPzUzIkePCbHBH/3ZOv4DH6/eWNrjawJsJLN7nJypAlL10aqPaO
   TJTZLLaQCKT8ZfgFQxsR1KIgCCYmxvsAW04zgX96BWA1q1adICsNeE31g
   A==;
X-CSE-ConnectionGUID: MMlNuf3hT5asvGoFtDagiw==
X-CSE-MsgGUID: ojSvBmylTG69Vt2F5qbaNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="49917441"
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="49917441"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:33:25 -0700
X-CSE-ConnectionGUID: hLuaKPxkRduksmvxyZcqqw==
X-CSE-MsgGUID: P58MD6jZQnO7utnduWzcuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,220,1754982000"; 
   d="scan'208";a="185333649"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 14:33:25 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:33:24 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 10 Oct 2025 14:33:24 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.46)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 10 Oct 2025 14:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbVEMqseBhW+9ujtoaaylaPLRElGgvjAPc8tqqBmVUsbaX9IEEie+8uh2xqGBejB0G4L/wKAzEY0RsOgLHSmv1TFVZMNzielUMbvB5+ak5qzutwAUJ3lSjU2cMSHhYGIZZxhbVRmIDroTzW/h+TEbxJM/zZ7AbWy3diz8WWCR1KuxkSPrRNwcRfyzVm//q2eWZZB7TI3qFHr3AAumEj29aJI1x/wBnvbRmOtg7Djyk3qhvuNQSZNLNWfVqg4TfY7Aconz/d4vaswCk5L5A910nThkuzMvW+BTDGqzLNAWFX5CB6X2oNO1/aQAyZRLjffefCxfegvrH96OGH564Qnwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63uVV5nUbLquBhmuSwCuQDwnnxShE2gE/cgQawWifGw=;
 b=s2T23uLrpgF0sj4BmZH2D9clAG8KWH2F8/KpnhKdtkTzCYCsRLBVwlAxw7UGFgj/6yvFym9yr+pDmUddlArREKCnvzrtQhdindXwsQFRKH4UKuSCmCUQtVOWVpuX4KL8xLSwJ7gd5gRfn/PrPzTvZ07YnGRUG+JuEWhYfJzNNokJaDQEB2xWpTZ9S41/0iqM4lM06Z7IgjAg24aOVpcwWeqJT190nfhzvug0x6sDQ6zOoYY9ZpVDpzot69j2MyIjDKavq040aiwmIbdq00pErN1nIfJiRdnSnXrEpjN6LTud3J13UelT0Zy1GbtKYSKrtJR/4mOf2Zk9KU5Cyht++w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB6916.namprd11.prod.outlook.com (2603:10b6:930:58::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 21:33:22 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%7]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 21:33:22 +0000
Date: Fri, 10 Oct 2025 14:33:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>,
	<jonathan.cameron@huawei.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH 2/3] cxl: Set range param for
 region_res_match_cxl_range() as const
Message-ID: <aOl7nv9LpUSZswVF@aschofie-mobl2.lan>
References: <20251010205755.205280-1-dave.jiang@intel.com>
 <20251010205755.205280-3-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251010205755.205280-3-dave.jiang@intel.com>
X-ClientProxiedBy: SJ0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::9) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d640028-0107-4db9-fdd4-08de0844a307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9tJV7/r5W1Rf9x5xgh7Fnb/DoMmN0ENHZwCpqgj5N48KFtKT3tQ4ViLZOCkS?=
 =?us-ascii?Q?IUtxNwDTIn0TY57UZ1lT5uRQtx86ga7t7RIvvTFRrJUcEQKGZidSbUTFu4Zl?=
 =?us-ascii?Q?8dNSEVmIpdZnZkFPCY3wEAeSUC7sj7ZsKIKOxvaer7oxn4Eg6V6D4h+I6Bvu?=
 =?us-ascii?Q?iB61NpbSbif7WpvTPauNoKpKW+CZp+TCYcmVXvjDamVChOLF/ltGu4wvOPfs?=
 =?us-ascii?Q?HapK80UC5yO2VTpSMfNam/LvYTfnqXRhR74ZXsT2keIMl41ufFbZO6bsHGOA?=
 =?us-ascii?Q?B6QxwQlo3YcwNCusftrUO58YOoEJEEvTx43x3E7LaqarZtWiDNPV6LDX3sZ3?=
 =?us-ascii?Q?kPz14+gGjXJXNQuCc/Z8AJRZg7MALPQblxVLlOhYdOsZXvuRYhS5+MAIPRkA?=
 =?us-ascii?Q?G8QCx6b/di/aNZxhg6H01Hoa6RCjlCSXKuhytfDU2LQluIvt6lgMAgRvtsEs?=
 =?us-ascii?Q?8CJhtyamZ4Ax5RweyaCKsaHIzBrSgpphEumhI1AxEughagJFKYIVv1YJsLcs?=
 =?us-ascii?Q?OWRVdgprsH3/55bWxikkiEqIFiUWJVXetmQ6T+7lnxHIvK72roUh3uoNvea6?=
 =?us-ascii?Q?aO3osCOwsX1ySZlu+m8PZBfM0F4QxzLnFKW80TU5jAXLNBQRTxzSMWTJTBJv?=
 =?us-ascii?Q?gMgie0RVhEJH5ZGOY4yK8Ix05TM74RUyX5nYC77+Kqq357QpSDz1XvKhIc01?=
 =?us-ascii?Q?BsBZdgTS6t6BktQe/ClM52hBJnpmP1ZlcqyIu1uvjCOL4ol7MyAplclBoOef?=
 =?us-ascii?Q?V2yeiWXuXI9IJDdcvYhI2m0XqPR8oz/cUKDoQwmfKf9PK43xJU5uAJW7YMuy?=
 =?us-ascii?Q?eq+/KHncDrUYMf1ZTDEbDa+YnTGdnpgCAMqtJMyzeykXQFd0KukaKG2Fd2FE?=
 =?us-ascii?Q?TPavyDIbbhOhQYvt6aG8wOTSIdl3C1pBgaY8omHEImvjHXsUdyfWSOLzh6Ug?=
 =?us-ascii?Q?Azc8XGYdImIGABcli87Kh2lrsLic3+4W8cQChLQWAYkrF/VLJ+MzK0IPmqPu?=
 =?us-ascii?Q?hqdh6bIp4wIWrN+g3z/o4Ne9ongvP83GNWYN1A2Vbmfgqh9MITUMRRFCaJE8?=
 =?us-ascii?Q?d4D39UXlR9xQrVQMUzMqWl3W1wHs31W2hrZ9Tcr7/+nMTeGNzoJoBJRytcKf?=
 =?us-ascii?Q?kn2aCxlmQuXjZmQP9yygbd3eJWPO1S4tsMkFACuwD94eKdHcjIF7sfK8ecST?=
 =?us-ascii?Q?WZcTkRrm8cOn8pK6Ydv+dpQzi2Fw9SH4F8CpyPI6DCFwa7RsSg204zmcoqxr?=
 =?us-ascii?Q?YSpomPdLiNjw9ZnEYpDyPmJDSkq9gQ9flNfP1xxzdmUdvAKek8oaHnihDWeE?=
 =?us-ascii?Q?ZzqJUTUAsbQ0yMJyqi3sVF2YW+5s5afJMikNZIi9AoupqSWVCXuZGEGedbOm?=
 =?us-ascii?Q?MPh7++nvGWEtx23wB1Z0SxKdoUuU14ew/TmSxVzDBo/437XEKft25xNcE6mf?=
 =?us-ascii?Q?SAs1EJgWAHrEsmA7fWvrV/QG9W8pvrm7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vuz6T6tpx4gnDuIohc5MHLROCZgYOWBRIlDlUvcnVK2dr3WSJSUKg+IL/8+M?=
 =?us-ascii?Q?QRYbbobVmPeEJ2XNO1Xhr6IFwwj2FFgKmS3PgtGo8ovAiOxtXWgS1vvBRkl7?=
 =?us-ascii?Q?j/RVUVZ3FGt/29EzNKqa/+cC5SO9/HgWXyxIC2xXtqlyDY/i8tqTrT032MmV?=
 =?us-ascii?Q?5oayaUXrkOBLdK7Qxjqd6lRRtNmyPz05+euFuPU+4BdG3tjq3coyPjvwiAdo?=
 =?us-ascii?Q?BX1FwLkr0gkeMh6Jky5HtR1tmNoQRhsy29J8BxGFqO3Vr7ohGtm61ZIYX1Sx?=
 =?us-ascii?Q?lz3oSJ17PD+GTGfb2xweHeuABHri6CIFCXD3mifzy5lh2pWp8zIvtysuWDXY?=
 =?us-ascii?Q?/kb5gG/uhziQgMdJplF0wW2I7LbhZujjd1NbxJJx2qHYOpiaZjXpKGEwjyuA?=
 =?us-ascii?Q?Y4lVY0v2bMMvHCf8n/hjloNc1Bsjyc6GxCmwdfiQtsg6e1yaOCHjvT8tIwlD?=
 =?us-ascii?Q?OBOCV9V/325kBcw3PYZyLGqfyHPp9in+St0VhcvpnvU/H7vgSbcsqJgd6Tnl?=
 =?us-ascii?Q?08kiBFjH+W5XLQHxggnRtorpLwfhqmKgq7xEehvFTF2VoplIUd9iAjuKyiGd?=
 =?us-ascii?Q?BmWzCWCzvkiskrJmXQz0j8JUAVn2R+QApv0oHH9DkDbIDxK3XMxNUKAw70uJ?=
 =?us-ascii?Q?T38dPoVLzYMhk7YRnYHkRyoPnIEYvS8iu3uypeFLVKlW/d2utAFGF7jCfrb9?=
 =?us-ascii?Q?dPKNcc0yxKccNFmTPo8IYOREaTjyXifsuh5+OQlgi4apBJdmOR2AG9vLSgh3?=
 =?us-ascii?Q?zt+KxJksc3WdFCwevtSNVmdzjg3rizoKzEiFiepTaE9aYzXyYXYUOKRN1aSn?=
 =?us-ascii?Q?cNxUSiw8nGfNJovZ19nfUoWqp9eHTxFrGcHaIFFDL4sOdOP3fZhQDzBGb+6z?=
 =?us-ascii?Q?226hlQGXF7lQglf5xgqkiC6qGDJWq7KcfB5T0RPhAcyv3ZeqiH6ZLl3RO5Vm?=
 =?us-ascii?Q?JlY5hVQ2jYy/fBCOeYaaRzpMNt7YVDIe840Notb63oqIOI4zCyLTTB/dt47z?=
 =?us-ascii?Q?/5uQ9qOi9sHQSLtb5UgLClxYjfdYcDoaV7Za3J42HHZAbpDG/RQEVvHYwhDV?=
 =?us-ascii?Q?9Pl2OBqkLYkkTnlpyFVz/QeiH0PgxOwv2vgaa+9M+h0dMDOM0EDXYlrkT9pg?=
 =?us-ascii?Q?8GbWdELSBvv2ftci4HFTv40xgDVTfG0Bnw5wqQZsqN9ykH5hISs/MD5ZizOT?=
 =?us-ascii?Q?FwIILDUiOFyi8pakSAQyxsliNZg6GbXTirXU8/OwkcFX5f5M0ayAKfGdf9Mq?=
 =?us-ascii?Q?OvQ8qsYbjZ+CfxjlQDuUo7YlPhSyXeFsF68subwDbqPmBRe3EAkNLFFFxzGf?=
 =?us-ascii?Q?LqAEwd/VPxrqJiM5A/EpR0Sth1Mn89yeeGeSO01ULZpBITIvB0TcXmOH64Dh?=
 =?us-ascii?Q?pntXffLj4SqJTnjfWaawRvEZi+FyjkOAR5D8R+QhyVnDwDIjVhFhpzfGH2xf?=
 =?us-ascii?Q?N6ZQytm6PL0/J70UGeQ7XQDbkLn8BkGsjw+Jf8a8cF529DghjPzSmKX6xfR6?=
 =?us-ascii?Q?KhCO6ORFIHo7W/Xwn0JvMeyBUVvcRAGS9Zmh5/3U7C7m7SS76Q01XWTG4FxO?=
 =?us-ascii?Q?3hdAdzzxmlUBFFfGKe4q6SXSbI41uD4xC3/PnH2f0ht6I2u4SMZg/NyrRtS7?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d640028-0107-4db9-fdd4-08de0844a307
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 21:33:22.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdKopY83BCcIEk9czYf1YpGJO8fOPpQtNkM1Lm4fLUqw/GHJTdqxnO8rdr/QLtILcgM5Y2tU4All7MOMtBe9pDmBmr6kcRa25zy8QaUr5eQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6916
X-OriginatorOrg: intel.com

On Fri, Oct 10, 2025 at 01:57:54PM -0700, Dave Jiang wrote:
> The function takes two parameters and compares them. The second parameter
> should be const since no modification should be done to it.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 71cc42d05248..0ce50998c49f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -831,7 +831,7 @@ static int match_free_decoder(struct device *dev, const void *data)
>  }
>  
>  static bool region_res_match_cxl_range(const struct cxl_region_params *p,
> -				       struct range *range)
> +				       const struct range *range)
>  {
>  	if (!p->res)
>  		return false;
> -- 
> 2.51.0
> 
> 
