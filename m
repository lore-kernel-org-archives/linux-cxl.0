Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C81253357;
	Tue, 15 Apr 2025 21:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744752943; cv=fail; b=Fi1ztr5m+irgEpCyINQqnT67loK+F17t32VQhEcY1GRo7HYmn7qZIbQmDFOZqpyKsK7V600EQMiHIQGhFs/95MiKUXcKwiZgkv7dVqd4EfuJb8s9m8WxGlvXm8FJHYUrL8tueZZpWAEoKLEgBJTFivI6e1C4/wI1givSkWEQh3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744752943; c=relaxed/simple;
	bh=GeLmQADco/RVS6ZGq0SGk6A6SjQFGRQp8xR8qmvnY7s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTX1XciSIyAmZIhtey7wa1AMcEat8ptYW0+balBJjmGyL5Fb4fNawnT/c3FbWJs3zoJ2vVl52aP0WQeimD0lO+NZZQJQmIng3jQZqKnPFvzfBr9hJW+un0tmN4aEIzweJljfF/2/DuOe63Yy500eoWO1nrXDtHXhPqBsJlSICPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzK+b6qg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzK+b6qg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744752942; x=1776288942;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GeLmQADco/RVS6ZGq0SGk6A6SjQFGRQp8xR8qmvnY7s=;
  b=lzK+b6qgtezhxCq/YHLWUs9p88EoDA6vfCoGnlAOee/cjR6Qj5R2HKa4
   B7jRguhMlm4ELN/ZO4hCiKbt7IY3Ho1VXqyCCj39QJqrjSmTxaCpctaTX
   1HQu446bUX3wgKaqNRV9UcxLUCqg/wtEK8MHn5K7tbjxzmYAWchWTTtdA
   D7Zerb8nR5DYzyxqzomJ8fjoLgaVIBoJ0EeuzoD1AmlAxpRfFqBXRCOpi
   P3yq+xx/4R445KKb1LuQsKWwqLNmX80wLmdqIHnK9NmMnHzEGCC9AwBJ3
   z21ITvqsvKwbFvt6ryUiWjGq9RQyIUYQVIgPDWkPQNn8d/6CLoHkL/s1K
   g==;
X-CSE-ConnectionGUID: 1s81Me1vT1OdDx2HWBmukQ==
X-CSE-MsgGUID: ZxItV6eKRMSr+XaUIzGKRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="46298810"
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="46298810"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:35:34 -0700
X-CSE-ConnectionGUID: /fyfuA8OQBuGkMHKgPDx4A==
X-CSE-MsgGUID: tbJoLP8XTFaaKG+MNw4uKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,214,1739865600"; 
   d="scan'208";a="167412846"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 14:35:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 15 Apr 2025 14:35:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 15 Apr 2025 14:35:33 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 15 Apr 2025 14:35:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7te0i0TCH5Tdo/GpGJyjBFZsmYHrpnLq10E1mp77OWTqSRyYbmQJD3OcVKWIRExPkUeE4VG481FoNXKl9ehrHa4lH6rNqJnDKDIRyN8ewNDeuDMo65gJoCq87qBnAr57Qw0qocPMUyJ9ca8pCz89Ziu/DkX8vRvP1Cn9DMZDAPAbv1SEziowQPZVMNmoM1JeNe7DQJY3BXY8NsTqnMnHizuk21/LN743JVVJ1vuoB9trKAAFcUJ1BsOtU2D0x2PyC8c34zVz9qbXPSXzJsXeMH+U0CMsJSdMdJ/AaTsAWNSWPKt9wX0oaY56WgZTKvfWHl0LY90uzFyj2/jvKLR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuTtyBbMRMWrj0ExUGbGO0O6uKliktAPZkTELB8UNIk=;
 b=qNt6+rQwzeBHYb33kzIdj8xVvEUPPcI/AxAsYFDsn+ip5oY/pmIt+8gfIt7a1WOpJnnVX1A4bXjZiPcG/Ja6wsbSCcNNk+MKIxJ+WOJ2BcQw0TFS3TkTosLmXL8J8CVzReW8bz6g4GOGWakfXy2sX6EA6JyhdnHBcn7R+bhzk4UEzazU/WIGQ0D2DXN7VjMexpYZHtER44PyhsmjWnXQaRJ6aXg+9vkPRpskumJ2sFvhhSAXaafw2Rdkut+i9/j5EjxzoDI96ncxB9ylhdPmvx1Az/qohS7cPEzjE2tJjnwFCYWUb95GyVv2XtS5Uay3kkpVFxrwuvykWt9FGXBrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by CH0PR11MB5252.namprd11.prod.outlook.com (2603:10b6:610:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 21:35:31 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 21:35:31 +0000
Date: Tue, 15 Apr 2025 14:35:27 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v4 12/14] cxl/region: Add a dev_err() on missing target
 list entries
Message-ID: <Z_7RH8WsN6bmOvRg@aschofie-mobl2.lan>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-13-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-13-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|CH0PR11MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a38c0f2-1ca5-4605-d139-08dd7c657262
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sk9JxKlu8Oa+7tlpOdEgOLx0yxofbmOVru/f+ABoDJj0RfwxwBaKM04vK79z?=
 =?us-ascii?Q?buEulUq/ZZ41yB3wj+3YAkb3jLh7uncf1WoQzAWHqt8tNZdhIdaKqF5hQiMl?=
 =?us-ascii?Q?yp8wDRLL1PRvIHLYiQQMNomyAtfRlxXoNpdA1inUzYUCRsllKMFH0XgblDeb?=
 =?us-ascii?Q?wdCqqrG53REtsuswsj/ZdzWbyq1yFspBDdZj0rW9HhzjOpSscs/sXWUpYN8K?=
 =?us-ascii?Q?3p2ZnMkU9l934ULKU/9dR9z3fmPHSOGhr6ccY7fN8P5ciJZU6tbAJkMkQWw0?=
 =?us-ascii?Q?C9EYLXJeENJcTaPAybnzZADA48PNxivwYH+CdGZl8fxgTjvPGml6LHHR0PGF?=
 =?us-ascii?Q?gclLqLaChXvQSL49UPu6fxfJgQWnv2hwjv85Rvey5vofebLkLmNibMtknmo1?=
 =?us-ascii?Q?rUVQc3X4e3AC83O4BYIi1vfP1m8W66uyYusWtCuP2M9TiS1jIKH0ES8ADUoA?=
 =?us-ascii?Q?tB3IiXptR/mSSK9I4qHYsJc6bUeXjAcYorkCswUglGWoKGvmvgXf9A5nqSU1?=
 =?us-ascii?Q?oQU6r+1zZAI+g9vKVQJZULrwNCzPrUpWwmq9mvAL4UJdU4wm5nGz6wYirb2O?=
 =?us-ascii?Q?wPTJAR6l8c2FfDrJVjruadScCASeLhrVEXdOh2cvDnQiFVHKGOdX4ldHjXVN?=
 =?us-ascii?Q?GSqrgOAg+9q+EMG3v7BjQYn4QCjZ20E7alVy3Nj9+vxyUOe1SVYXfIiletfe?=
 =?us-ascii?Q?k83oGGegoxyj7CJI27n2Vo78noicNVrgqsIJ228QUJK81/8M3OTpjblizOFa?=
 =?us-ascii?Q?C7Q9K8Um/pea0aHXCCDjSMtGamaWLrrYktixya4rdHJDWnNVysVIZHY9ztEU?=
 =?us-ascii?Q?6j2zRwSKq88a9jSHfgYAQKtk3s4k+QieJorMKEm0kUQI7jfDPaEdUoPrtlj3?=
 =?us-ascii?Q?70R6RXvpuqYbILbScJiHL/7oGs5edd5k/TzNiSoMEQctEwVwCJ7GxLf/WJLD?=
 =?us-ascii?Q?+5TyXK7gimsm4+CzYen/bidNVaUkrYl3h9KDAUh7jV/qmyInJOutbB/gBlHK?=
 =?us-ascii?Q?pjmL0KP03Y+jnyCAXkTSv0xrO9+PuB9SzSPIccbPUKU06IcsC6uHL4SpkyAb?=
 =?us-ascii?Q?fCjINrjUvjn6XT+NezUlY4aLJ+WS6AhG0+mUdl6uaXJ+dPGpgV4oIK2fE33s?=
 =?us-ascii?Q?gmzQ4D7JfYTIgZ/FY4wAdUsVU190zLFUwQeVDaRwXKSczJdKrU+eHdc9eJ3H?=
 =?us-ascii?Q?ZBc5zRUAYQWuAVDuYc/kv4efmkFlVLycD7U6U+ES995CCegJsM3y1OkgNaf7?=
 =?us-ascii?Q?98f7bnaNVxtaQaFeYkTGPJ/zlr95E/C3Pcf5CXDfQLxOzgNi5bObg8MIlhhh?=
 =?us-ascii?Q?JROvdGW4zdYe3ESe2KJhoCI4IGk9r4l1/VGCI3qXJ/37nbGmaGWhKCzin09T?=
 =?us-ascii?Q?BBwp9xULJzvUe9mIudqoQvTO7nbBCU4tkQBR26LlnOdYvcbyrTYMHXBvS3Db?=
 =?us-ascii?Q?OWwPIJGiyS0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JvEsse+PmalZq7+gs3+MXRP8Qzh4pWIdyHh0cpjXI/fFx71x1IREmxQprHa5?=
 =?us-ascii?Q?6NQ1b9uAaboNnK0S/PTxC+D0NduNkaOmg0RRuTLft1t0KshPO1R1o9ykbWOw?=
 =?us-ascii?Q?EIkHlpDe+wF/cBxhfHcENmHcj2kkpK54b+NiWFVBpNglhdp4NjghXWQRxgHm?=
 =?us-ascii?Q?Oe1m4ylKmX/GEXKiAQATinWShKIvPnDAhhZpna3BhtfL0fnxlUx/9aH4jokg?=
 =?us-ascii?Q?YFdegILTiOde/kGBG2mpJmj/dUaMxdB+CoeH0OA2G73Qk6C3isEs5+iesOgM?=
 =?us-ascii?Q?8LzDY1IuJ4sCN22ylp2Rbre/Zm2hjZ7h+2VbrYJwmy+bPg1YQb3mRn7GjMfr?=
 =?us-ascii?Q?UkYEjJRsTY4+lxZaoJllbLSCxkz2XjYRVXCibzBC9FP7RwPrLbcGHKjsmbHg?=
 =?us-ascii?Q?I7010S1Te8CxAHN+TCryeVEsBd6/0uQ9CdDIgmApRn5VFeY8odwFI8tA6nqf?=
 =?us-ascii?Q?F4XB470z6jWGRTuy1maa3MfHOUWH9Ey5cS2tEvKGb7xOcmd5j+eXRCKQyrNT?=
 =?us-ascii?Q?jrEpkorQmnMPSyL94UcKEOk9MPujJQROZUYg8JVVQA5wd8m6ZLYX9V+q1OjZ?=
 =?us-ascii?Q?WhvhSGtNzx5sNBff+0CDIOs1Gh7fN5UrQChPYT3UtzLcoBo5Jqs9y8HRkaKc?=
 =?us-ascii?Q?gU0dlwujYqqQFVsBwPbVg4Vwe9mXA/2FlvMD6g39sNEjv9j/Qzi+vcj1YA5O?=
 =?us-ascii?Q?flS6FTgKJZutwRPwSN5rrVqf1SreBN1oeYBiRgr0oT2kx9w9z/X4cF8sH+nz?=
 =?us-ascii?Q?uDelL37dv1DgD6yvif4zvxxDgsoNMXz0cbo6JpTCYmTBrrS4AlGv3E8iY3cs?=
 =?us-ascii?Q?aPO2ZHlA5gRjb8DItbyHpgpNVbXUSo3T3YMLLTX0AJzfZwDM81s8pTUy18hJ?=
 =?us-ascii?Q?Y3oL5W22CZ7mkTjqgPUfm6CfI5wDXuTzgFaq8LtqFGR8Fago0H9wjj4QqYEi?=
 =?us-ascii?Q?fCZLRV92dmcnbrurBb+Fo/5ancLlTH5mUEvfVQrgSRe9HVufb7Rdr4yfngeT?=
 =?us-ascii?Q?kooUd9JTx9GSDWxftxy0iSb6cTJoHBZ3YhgySpjfytoNknB6iZiy+2u/uGMM?=
 =?us-ascii?Q?KtynlmPIpHKry05Oud9421qjc/3kgAILlOUozwVJsvWuDqkZrLCygy969H8f?=
 =?us-ascii?Q?Ovt2EgGwjzC2+VvhZivbsH6Aw7V4ocjG6179KmlK0bnDXhcJD5BEuTo4xJsP?=
 =?us-ascii?Q?EDm6GLtrTStGQJiv44J8xe7rvszhigPXAFq6bVxvTd4jMp+Xdl9TGbjDGUQ+?=
 =?us-ascii?Q?SpgMsxmmu+MPxarCnignBnT6OlFBG9LJi8my3F1hnIiUJkL9/xSsBjufvZNc?=
 =?us-ascii?Q?TeWmdFlSwY0RBo9rd+CX0ei3feTS/9TrA1st/h8kBfft5lH+YQbt0uolv4X5?=
 =?us-ascii?Q?Z3YREYtogDjY+4T2ztkDhdbaLX1ADhKqknZxbeAvsLgBSo32/fewNWZS/Bd4?=
 =?us-ascii?Q?cAFXLpkOzs3sw/RwevYO1OY4462zbMwFX1tqhm8MVIa01v3D/pDZZ//Re/dp?=
 =?us-ascii?Q?QBsDV+U1XwW2Ex6jKLNENlEbR4LgVAa4dipWFdKGe89PGfPsJm5D35gc0c4+?=
 =?us-ascii?Q?ZnFVg98389+FiPGNiiOXpMK50xF0ZOmhu6IK0bc2JVJ4qYLAxhgxmzsfc+MO?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a38c0f2-1ca5-4605-d139-08dd7c657262
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 21:35:31.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YskpHM1RFRMkuDqEXksyyI1ec6MZ53k5O9KOHPR6ex4lkuFoiMf24PltnN7jkhPH2dl4yxx/V72HwWzrIc/mHIrztHBfb6Vz2Ivkk8thWgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5252
X-OriginatorOrg: intel.com

On Thu, Mar 06, 2025 at 05:44:46PM +0100, Robert Richter wrote:
> Broken target lists are hard to discover as the driver fails at a
> later initialization stage. Add an error message for this.
> 
> Example log messages:
> 
>   cxl_mem mem1: failed to find endpoint6:0000:e0:01.3 in target list of decoder1.1
>   cxl_port endpoint6: failed to register decoder6.0: -6
>   cxl_port endpoint6: probe: 0
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

