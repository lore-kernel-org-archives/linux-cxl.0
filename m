Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2043.outbound.protection.outlook.com [40.107.93.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE2679FE;
	Wed,  5 Feb 2025 09:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738746056; cv=fail; b=C/UGFrNE1W7CVSuF0ehD1Qkp5dtXbAahbWgteuNw/hdyVDK9tb6dLaNYNUSUNa/cyrqS45UnYCeTyCRA1o5BKzrfpbnLHSwVbgan2m2O9NyOajBV17IO8E53124aMCPePCGNl6jf5poh6PXXF3HaaPIf7kp4nDCis2/Xkwj80GQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738746056; c=relaxed/simple;
	bh=37QluOo79PErikIW9fuLIgZFPbu5qoQobUCzi8udGGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ThZbe+bfF/LI2TwPKo37TvyPsC12MoCaeYZQg8+AmBPwzvRJDP5xBjZOUI8deW1QVFcgH80KGn8IIVO/QVvMKAr/bLG2Wzb+7bw6voH1YSqRAacC/ss0CImaOlZLfdr/O0kGwAzzmTt6z/WsgKPnD05rbXkQcjdCh6MUMuSkoas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Xa3XHG9v; arc=fail smtp.client-ip=40.107.93.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Xa3XHG9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsyKKePVhl6Bh3qp65os7tmWxvaIVVkzkJ5+c75uCOak7FZJ9gbxw2GtJXg+suJ/mwU1d4cbUEbVLVFFFxe8fY77SVLMbQP/ssyuGb9Lu4cfkVrvvHcCZ9mQ7+phvB1gQzJHxsL03iMKxxySPJO+dz1b1n1cl14FzjmRMStr7J5PDTPV+A2VcFqp2mL7b5QN9Zo50SgwMw5R2sgRaS9JsugBlu7mW7FP7AVzgBWh6DZPTC8P3MAdbYYj85qnkUhPMNeyQ0Cf/GSNN7TUrtAmLJfTsSyL1/j2xxNv25sytuxrI1QgAEwlHfCmqoFqB1J1yhrHe7JrAmAd20f0vpSctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vslS3QBm+/tdTApTj/0+VqDE8G+MgIc8ayQwYmRWYg=;
 b=PW+M+fFbo7wkZYnXnwiMJK68adg64mNRkrZvbNfAjHFg/x3C1JDgFedoaM8BZooAFGO0C/IhBtyffXEdDyzV03+Ey3HIeSrRclDVjaK7K7biEoQ1VYY8kYYDQ48xbjSgyvA5ogcxICHjUgqoHp3d/eqmsOQFa62A7GdllYm9n6sOPoDrqDxplPktNdNbd30WdqxLs+NMX/OqrvL5vRoPtebZvFrCY49Rb0A0NO+Nc3gWnC1yN2UzZUaMTv6KSlur4Iwmu9mrM9lldAMc9bIsuh27b35tKIsyMZOpj3FgpIJkGhMF9ZhNRCPabneg4LdNOoJnE5LcNej1Vz+ommxQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vslS3QBm+/tdTApTj/0+VqDE8G+MgIc8ayQwYmRWYg=;
 b=Xa3XHG9v+JbBTSv6C9W2kWCxfMA82YtiX7Q3nyQt7PrApBy6Z6CLVLY8GN3IAmZTIebBT1h3Mb/pNkzwf4V1ghUxmBmHH6uMQTWxxsCqSpb1h0IWim8/rcX7reEvrliV8PWxOawJDcX4O2XhRKyla83R8JF5tfN0DmoZr49kie8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 09:00:52 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 09:00:52 +0000
Date: Wed, 5 Feb 2025 10:00:45 +0100
From: Robert Richter <rrichter@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to find
 a region
Message-ID: <Z6MoveIYE2lcTdlT@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-16-rrichter@amd.com>
 <42f95f6a-8c92-40b3-9ad2-623ff4d8267c@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42f95f6a-8c92-40b3-9ad2-623ff4d8267c@amd.com>
X-ClientProxiedBy: FR5P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 06aa2350-6e94-4de4-f225-08dd45c39776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/1/vB8XFn51n6mehRTEQZvEPIobeSuln7HENFovKO+a1HI6RTKq8dtcGxEL4?=
 =?us-ascii?Q?w7HxKNwlcDdKSgFcuXCCJYrgfvujouCGpCH5hx+xQe5lkUMcMUOsqR9xKYJU?=
 =?us-ascii?Q?njsk/fMc2bUNf5J7kVxRm99Lm/6XmBBTXRpHVCrsoicbjo7ghQG6Ymdi7u7K?=
 =?us-ascii?Q?dUx5OrO+bAYT96ROiPLb2phx3Bx/8Ff6Y+dmV+u/OGVQQPRc7vVGOcMv5YQ1?=
 =?us-ascii?Q?50Vp9+Q6+H+KKo7jy7AsWXtssjcwMAdkS5PVtOsZzb5asv1eRN48VOgcFb2V?=
 =?us-ascii?Q?MfWcuVV/zPMHR7IUk5OWaIOpZeX6OdI4ItCkBu1vdUcKPEgEiFuQ+4hv9BkB?=
 =?us-ascii?Q?5XCzuv7KCuFLaDtyGRbDTH12oxYQ7ojQyiog4f50FI0XjAlg6aIMPmd0Rpdn?=
 =?us-ascii?Q?6phLaF0dVfX3+O9ZUqIDQOVsFpWwq205vF+cPe7ziWIspMNNr5jKcC0Jh1zg?=
 =?us-ascii?Q?qjlAN7GRaZ/mWyDp3YM0HjYSGmeRB+jcAmfEYwguUKPWcwpYNmZq4/lzrl+d?=
 =?us-ascii?Q?k++VJ8Q5V1sD6viUOdxlBvFc4PzcQmtNPhHZ8IewHXkLosiwJGzpa+mOAMTr?=
 =?us-ascii?Q?Ef2/Yc3wxl09JbjYBqyM31nJH8dkisTHnvXVMZ8GoOYt6gB0w2e1M/l7peDL?=
 =?us-ascii?Q?Zsq4VsSgj9EzsBNpDaqMssKRJ/Ok4283/pMIMzi2ln/Z3j8MalxvhqtAegcV?=
 =?us-ascii?Q?eBpkBTV9S/pQZmq0/sXjqMqGVHTdpSqWbKKlEA+MnSICqeROymhi/4Wbt+6c?=
 =?us-ascii?Q?HRFccwXMBIngV99H43pKca9jtVSol9KfwUm3NCoj+F9xo2f6jdX9VXJR0Uzt?=
 =?us-ascii?Q?yxQCexr2JuzQA+Hxih4nLagivRpTIJRqLm0p/qCVpNyFS5eVGEG4qX2cvHgT?=
 =?us-ascii?Q?owU+mW8sMsebzBlNd2rM8z+gLNMNQx6lsWnDsX82lo/53lBIGuPuKYay8oV/?=
 =?us-ascii?Q?pru3CccqaKS32CgZVE8UrNduE/7RDIi4TTHmsOA7n2CyGTBY0RO6xlLxlKnj?=
 =?us-ascii?Q?usfCWmFNKX6SIRpTfPfWU0hMcF6L1WyXTE3iNU5SgNeum4COfrqR+NLv3VpX?=
 =?us-ascii?Q?ru9HJC5F5dbzIcuBMjtnKyS2HoLVGYNGazFxNVZ8ExQnq8VEThVaUy1UV34f?=
 =?us-ascii?Q?Dbxw1qtDkYwNJqFL8E4aM7zrhRf2i2qbvrid9Kjs+7nXP5mX7xZdx48Y4QDH?=
 =?us-ascii?Q?P3VEsP7+pOdhAVTslL/bm8Ggqmr5Cd6YSO7sDA+LlN9Pkmn4mY7C+z0W1q2T?=
 =?us-ascii?Q?oOpi1fWewesc6dOKqx8ByGhaoAVa5zfrd3RtVm6FfqeiSrFJa41C/GrlT2gu?=
 =?us-ascii?Q?Uzd6rJbatOh6ZiTXlBn8vwicfgtcU0wHC9PxQRbpON3IXl/kLQjDCymZSiC4?=
 =?us-ascii?Q?x0F+HGR2Wb86U4CdvgroUhTy09+S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OUkw4xBw0haQ7JQqsS3hf1WNroV2s7IVIJJE12tGygiKsSwe5sCHRyCydyjh?=
 =?us-ascii?Q?4PFjCDnEaTE/9+VRnWBWFyRZL26D3k7JWHm/PoPZ7AOaMP+ADMtxqr4Da6/5?=
 =?us-ascii?Q?L5yKGzrB0OESxQ1EWblalETiWA4IkNLPFXW0WiZhvwDRWieT19zHI7PD6qHd?=
 =?us-ascii?Q?X2KAq8qZBoukRaTjxShzv3jheeBs7pXrVaJMMko2KGNLsyGgxDYM0FRGdGha?=
 =?us-ascii?Q?CspM+TqwEP8GQ0MvLufEixe1MNfV49Op3sD6ts5JswDfxVWa2V/iK5E7+wnj?=
 =?us-ascii?Q?P/cREuW79xn01wDz7/KcX87JAla1vlCpU+M61WfBNHXxUSKsvol6ui7/e0Nq?=
 =?us-ascii?Q?DF1YKZooOhsdR0ocFip4BJSfFAx0Ouk6Z9UlF/tFp7gh5C9SVnwdmxXxn1jj?=
 =?us-ascii?Q?wVo5Qdb80/iZiCkO+6jOm4ZfbaLtph+efZlyXZJ+7lJu+p1Vgaja0b1WHLfx?=
 =?us-ascii?Q?NTVF3stqiSZB+YoS+LB0zljPoZ0EcNC5nn9gJzl3Ctf0eCEMl3UvOPlFb4bE?=
 =?us-ascii?Q?gOvGk36hWgN6YKflHys0+5S4QEknIf2PFojPzVCcQQJnB5cX2+sd9eeMANYh?=
 =?us-ascii?Q?NznVAMOm5pYM6zCH4OGjfqT1Mjjb5goPdFP4y13ItKa4sLo/AFBTN6IBCPdm?=
 =?us-ascii?Q?tKVfFstcOK2sHGTmxLrSEWIY8URJQl3s6TNUQOrWc4wDvRCitBtsc6/cW2sn?=
 =?us-ascii?Q?KnmDQEeymTGiZf94twNZsorczxFShsxJr+CmdxRMa3LjwDriLbaE7qP+0vPe?=
 =?us-ascii?Q?fZdswQqfJQUyU7fXbWvrR5yFkkF32xDikaoJFBcwl7QiUgXqOATDG4sZCcyR?=
 =?us-ascii?Q?fWrPQB+D0OI0gS8RjEnL6XoLzGAh+4lUTUOsGyoaSaM43z/aOGU/3NSgf5M4?=
 =?us-ascii?Q?VFmsDY4nAtp1paAji/Jm+VmO24mjktv++bWk+Gy/z7d7mZMDpuSzHpOdpajq?=
 =?us-ascii?Q?aRIou1ds3BV1tbngz5s8G87PX9wfO/RLO4c7xCQCw+A5lTY/Fx5vmyXnVbhT?=
 =?us-ascii?Q?acXn6bADGD/jJrrVUzb353SnZaL/GrdVaj20a4eVbCVxxqW7z086DEs6V4pd?=
 =?us-ascii?Q?Tf7vU9bRBq2Spc/XTY4yLq/lQsK3UxJFX3nKE3NBW2U7YabZVAMcMZzEmdxA?=
 =?us-ascii?Q?/ZALmfdab/5i3UI/VtwCTU6Rj5YHT7x8b+jebbBsdCBncIGCSXgXnkG1CiUi?=
 =?us-ascii?Q?bPdskgIK2RD2j1DLAs2s2+4ci52Sc4ODTV0uGLhWrwT/QoUTtyG5a41KRliL?=
 =?us-ascii?Q?jb99JYNstYJdk+crH7HYgCZW/uCoEKKTkc/5ffxIvs16xrE27HfH/Mk+CsQD?=
 =?us-ascii?Q?3z4FLu8tLZTBlu/mlNR5/+wz4phipF3AycdRm5Fo1sf2Tlq0+WVSQO+BRlRP?=
 =?us-ascii?Q?Ix/fgYn5XRjtO4X0z36oqP0d1mzuFckBhkeaVYmpSCG9YnYd+G3yt7+aNDLO?=
 =?us-ascii?Q?nmnzHyjcuVfwXuKRumYbVo0r/y7Jf239vMwTDVqU2MlbNINvaGuAY84mDKoD?=
 =?us-ascii?Q?Ao8bQzw9C7eWS+KfGGxXpBJ1SrvBdBSdeNI0w9vpTmQtGnFSLxi1aAgwMAVn?=
 =?us-ascii?Q?HUageCEefjlhjtNHNI0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06aa2350-6e94-4de4-f225-08dd45c39776
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 09:00:52.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63asKxgHRPW+H/Gr0cefi/6GAxSKyy8hvrvYD/S40DH9rbVGQdvpg1W1osbP5scbjD/BlpuCzeNmGKifEaYCMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170

On 17.01.25 15:31:43, Ben Cheatham wrote:
> On 1/7/25 8:10 AM, Robert Richter wrote:

> >  static int match_auto_decoder(struct device *dev, void *data)
> >  {
> >  	struct cxl_region_params *p = data;
> > @@ -3214,26 +3249,47 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> >  static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
> >  {
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct cxl_port *iter = cxled_to_port(cxled);
> > -	struct range *hpa = &cxled->cxld.hpa_range;
> > +	struct cxl_port *parent, *iter = cxled_to_port(cxled);
> > +	struct range hpa = cxled->cxld.hpa_range;
> >  	struct cxl_decoder *cxld = &cxled->cxld;
> 
> Can cut down on the dereferencing a bit here by doing:
> 	struct cxl_decoder *cxld = &cxled->cxld;
> 	struct range hpa = cxld->hpa_range;
> 
> instead.

Changed that, thanks.

-Robert
