Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0163E8C55
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626908; cv=fail; b=HpqzFLvjbyG2+snCJ0Q3yxi++5qm3oGf8hY97eYGLMHTctj1QDgGgbx0z74rFKcd9QkucaX5Ji0wKsnizzb3EVVLEI3HIi+/brj8UwNiIwd9WQ3isVLbn7mAIp+RXuAJhS5/TuPmpNeyUK9PW0a1P+mfxEaHwewjKOcQtL5nfFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626908; c=relaxed/simple;
	bh=JFP7bohJ4qfzMymiQpFoH25Z6LKZNHR2YQ/fVsIGTpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qe8Jp2PYBc8riJIMpK2s3z1f3XnqCskS8CoP233Jo/iZsOosMxAN89nvYoQwTARhuGihkSFf2inEI0NvCrj7S/zXYOUseeDk/LsVNNkk+PV0pR1+bHkpcW9My/gPQoYF7gOh3I5OJOGTyljTYJxAnwDnfm5zWHsMgdhhxHGofcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AYEgXL2z; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AYEgXL2z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gk9YAadqSVz0yWuyIl9G0T/DT+NHI3VKxbl498xRdLUeACXPMNwIsBb20G6FPkbZY4ZL467EbEvUKQCKgee3Tdtepui4WDcrA1YiXl6Lw8SJJjVD6MFutcw2JEgLO4kLhQ2XNtycp1alVdDNF/2zACBXPO0eFSV1JFDm3irw/HlsoZJ+VjxdTiYnH2qFdqPG679nz5+sJolyaeGPLBVIL+ZRsDc1xB8zgdUYlRzxKVMzYQt5eLKsXI0bZzoLDWrggDEtqRCY4/KslBjf6zJXsRdTEdrIV5NxRuabaCmXGWwDhwANub7pvn6UB/3sPecSgmvzvuX5xQ8HehfHTvpBLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aqmtrs/2tDXYAKnnqfjBrGBbw18cM9/eYeHx6A5hJM=;
 b=pBu3w4gegNy6ht6sX7Kc8+OXytiTVDICjkG5Bcft7k12Ou/pTJxV971CS6vtit4QmD/81xT+knbWrI7+lbLRepqj+Ykqf1sr29TMJhdIWtncUtfSnOB6WAP377/bnW3fjxZM9ciF41LP9HCG+v1o6kcsUOuaLAP8lgLOvC8LyRNZ6A38cc2McGmtBEQbJ6lE9ickxEfHV3M3FMlifEb6yGI1MzwAQALNtum+/Hf2jdLFAvIasVr3lx87AuMbKlxF4+dsVp0PIxqKxeI3GNsu8vLG3Cn3LR4+Px1PmZ9U4yiToegLp5672ugylIxH509V/X3Png898LmpHsFazfw5lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aqmtrs/2tDXYAKnnqfjBrGBbw18cM9/eYeHx6A5hJM=;
 b=AYEgXL2z7Lbgj1ntLdhZMcaYOFB5Pyszjzkpfm8J9LJynbNPuDL1ClJTNOrx04Tt0I8+5RqNY73IIhMYXDhzS/GZnzWXQIiLUdJp6THbEdZiK9yf1o+vll31Bu/GYpDf05B5FyIt4P0Ngh0qoWY1NgACI7w6/OPpORlMLJLVi4/gceup0+XZ93Wwq5+G1Y7zW+gJ6jlkb70EHq+NghiuLVlQecg37DFSMD8in+36+FW6CylKVZUZqVKx347eF9MCLEqD/bG/0fezjcrUJ4cbveMVmOVuJ40eoMfR+CyKi2m1TdCQhC4WJ+E47J/PCE1E/IcLC5IsFyd2iY3JGvUj3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA0PR12MB4479.namprd12.prod.outlook.com (2603:10b6:806:95::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 09:41:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0223.017; Tue, 21 Jul 2026
 09:41:44 +0000
Date: Tue, 21 Jul 2026 17:41:39 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Li Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, 
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v4 0/4] Harden HDM decoder enumeration
Message-ID: <al8-sFxzNC4v0Ply@MWDK4CY14F>
References: <cover.1784595445.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1784595445.git.alison.schofield@intel.com>
X-ClientProxiedBy: TP0P295CA0045.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::16) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA0PR12MB4479:EE_
X-MS-Office365-Filtering-Correlation-Id: c61f45e6-628b-4a97-4016-08dee70c462e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	LuNYm2JyCM/Nz8fFschcZZ1xN/Pb06cdH+q6IoqRSi8vIT8rbum6xZ/dotUVUE8Sp75TQfCsVNc9rM9Iz+a4kq7a+1NVxEpgOOkHl7DUbZ1Q3q2Kou9v6T9Gol3sU+oIG8gNok48UX2HL7gRNivPAjF0aShl9maN4fMdySm/JngonW/iDM3Qb4vf+//bd2pmvPhuuUqkQ1fYh2Xo+xJLFbP24b+xFvgjCcdeOhFFvEnYyIxeh7oX80lXim2JfsJ/uAbdqYRPWo5hDFiBZqKUJn0GsCWiVU/W+oIdt2jAN+8YtIbQZvfwMIcVsbV/sKpje3t/xvbZgaBPy4xrdWQr+qT/WdXIj3Q5ZxB+KFsY1rlaxKkUvKZQFmGVyzUZM1s/v4z0eDXDBYby26j+0D4/gKcB+VGya3tUke8vQA2LC704jUaBZGNCfoIroCZjxRJch+0JL5GPAuCxpPeCL4p1quAPhcwMFQcEA+qfn1xhBMlxoJS0+Olbd2iFLPfXrFVK0zlqsQxzXL7kdDwM3+ATN5FLMT2DysyIOhvICpEJ1gZVgVaQZBAicmg7RTt3cYOz9DJfJv2GUJsF2CddyBZ2bhS3+k+Rt1r1WUy3kjlIqAnoh1nWiyEdbMyf68zufluTJ+teN1DPJOawQWH7Q1QcdYYUTlQKZUoTlxLJclqBB7Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rq5O4fqY4gPd5MmBXvhMwhgVOdQxUumV9QSJTYIoJqxHyJXxJfUnqupu1ig7?=
 =?us-ascii?Q?8TK/dIMB1dUKly6puzzTOpghFDVpjaehZlSzPqdGSHImEGWU7E1Pda6YKY4N?=
 =?us-ascii?Q?KdgZbH7Rvsy51Mhl+n1I/NNmar/n+GvHIxi9DUKF2sEFY4yQVW+VEbGa/arF?=
 =?us-ascii?Q?6YXqwoVOTZaRujnosCC2sB+ncFZPxhWl/6GXJx6tC0TZs2GK8xVYHuEcdffL?=
 =?us-ascii?Q?D7sEIWbZPyeL9lcVo/3UhRHLGXda67H4WT1c+OXoQfZlNm+e5s7axIupgWt8?=
 =?us-ascii?Q?4uptrQ2vt2FwX3uteiOtlEIgfmzxKJKgA0uTd+mdmNHELt9PHnsTif+d6GsW?=
 =?us-ascii?Q?4RQQ0nGQ2KQMaejiQWSvE1UjfIr5QeQs+T0G0WA7LAwm+5a1a0czYqicxsUH?=
 =?us-ascii?Q?2J+psuCGX/FOFBEllCF+hEAeD83TEmfGszVWuQTYB07ajYVCHCEgi7h+GYO3?=
 =?us-ascii?Q?fzh7GM/uSO//cyVOYmkWmJfWSUHkm7IVIrkQYIShNSJUoPm9zWjUy9Vr1v4S?=
 =?us-ascii?Q?Ok8y/M+2+Xi1VC24R5u131PcMRywtR/AzGUuolSg8blG3P4hS7vmKFfhdCTY?=
 =?us-ascii?Q?BaLKlfz03UXLbMR3HmMn3GbrFJg33wunYmihz9mmnD5R6zYP5XdF6DOThNc8?=
 =?us-ascii?Q?HjtX+vNPpqKFjdSg2XCmf3hexWi5l4+ekYLIhXwCYK0U9QqYXWjHSTV7yH47?=
 =?us-ascii?Q?YcjxVIO80Bq/QquXzRhhPA/DN9c5VGLpyVwOMoZIiuHrL1LpUQu+jUvkwl13?=
 =?us-ascii?Q?p5NZwQQKygy9DrvHmHos5bRtwMylGBwGa0bdMwSgoiwNEeKkyugiaGYDNMOY?=
 =?us-ascii?Q?+9tGEX4VUqRVwbWhQ+6I5aXTH/LJt5AtpBL5FGRvnGOnLBhBKEoOiULsTkkQ?=
 =?us-ascii?Q?/yi+V3HN2rWYypU+OoXf1ntc8HjmIYnrDULourVhX/d33YjdS/00lpqO1VBd?=
 =?us-ascii?Q?H4XxStyXYgYu3d/02yPXC3ZTPXQgUL3ZgCc1Z1v2VeCe86QWXUIreDMcXqPc?=
 =?us-ascii?Q?e4G/zLyPvrQE+NVypjVEvo0E58JM1R95oHQ0LiRPqTXkdiOrf2cOx3O8Snme?=
 =?us-ascii?Q?k9kg6thCN/AeexRyKsvWo8+vwggRZ4iloerIOzu0i6lN9I7nlJq6fvk5yu2b?=
 =?us-ascii?Q?+Hs520YydWm5+OMwukwBrciaPLtVeOloChtcFkfjHd50DocUn1qoSEO/jIFR?=
 =?us-ascii?Q?9iviYbNVG1+0yCfCVfvBZV++xACmMBZMjm/Ay1aNTJzIHGM2HVplNqhrR3JC?=
 =?us-ascii?Q?FlEUr7ggn03VgkR5IKj/M9pTD2Sp4zRpqpyycwcVQLisoC/BQ1zxjvcxoR5r?=
 =?us-ascii?Q?DgurP/XH2t4GexQJUM7F/DJ56rbtKBVWyAu9Un0oycbx6dwGI6Uw9yFTfOg8?=
 =?us-ascii?Q?dFIEYoQX+V7PLWN8jB+sZDMEIaFuOoDJMdRycPu+cwIEnaUjwiKwxdk2fI0d?=
 =?us-ascii?Q?rlkDE7Dcn1XTkDO+7tcMAeGpvW2b3q2bFAWlKabayg0ufkxlXLVvWTF12pRa?=
 =?us-ascii?Q?vDFbKKMlp6WBvPz/XIRertnrCbT3agJjBfnN1WsYuR3cshTo4Sa7jO2ViHUu?=
 =?us-ascii?Q?NiRM2A0LwhpfuqQI8Z6YPHD1C5EqB21/wWNYH1OUoabFyLcSDGQvqXxoN5xm?=
 =?us-ascii?Q?XN3tLxgeynKy8rcY7PYelxm13KmjCHCTZBZ/4Ce75hvjjCNUY//8JfIzw3H9?=
 =?us-ascii?Q?T9BTcARnS8fUR+zTGiaO2HWYx3j0ZhjoR3lXgpBKQ3EuEgCOOgkeJPKWnsz8?=
 =?us-ascii?Q?CpFWS7PviQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f45e6-628b-4a97-4016-08dee70c462e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 09:41:43.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjfMn4O4efLlDVQLvj2fNrVfLsirgedbLm8C9/qwVArGVYLihJVUIQI3X+7vsRqncjXQ06F7LUV3veIvgnwugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4479

On Mon, Jul 20, 2026 at 06:59:36PM +0800, Alison Schofield wrote:
> Changes in v4:
> A new patch was inserted as Patch2, so now set is 4 patches.
>    Sashiko is likely to complain in Patch 1 for something fixed in
>    Patches 2 and 3, but reordering does not makes sense.
> P2: Only interpret interleave settings on committed decoders (Ming)
>     This is the newly inserted patch
> P4: Register reset w devm_add_action (Ming)
> P4: Fix up a kernel-doc comment issue (lkp)
> 
> Changes in v3:
> P1: Move zero-target reject to init_hdm_decoder() (RichardC)
> P3: Reset commit_end via a devres action after decoder teardown (RichardC)
> 
> Changes in v2:
> P1: Handle uncommitted decoders (Sashiko)
> P1: Reject switch decoders with zero targets (Sashiko)
> P1: Add in code comment clarifying target_count (Sashiko)
> P1: Update commit log
> P3: Reset commit_end on the failure path only (Sashiko)
> P3: Update commit log
> No changes in P2
> 
> 
> This set started as Sashiko reported cleanups, and at v4, Patch 2/4
> was added based on Li Ming's review and catch.
> 
> Only the first includes a link to the original Sashiko complaint, since
> the others did not originally appear on Lore for me to add public links. 
> 
> Srirangan: I believe patches 1 and 3 of these also address pre-existing
> issues Sashiko posted in reply to your reset series, Patch 02/11.
> 
> 
> Alison Schofield (4):
>   cxl/hdm: Reject switch decoder interleave ways that overflow targets
>   cxl/hdm: Only interpret interleave settings on committed decoders
>   cxl/hdm: Make switch decoder target parsing endian-safe
>   cxl/hdm: Restore commit_end when decoder enumeration fails
> 
>  drivers/cxl/core/hdm.c | 98 +++++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h      |  2 +
>  2 files changed, 76 insertions(+), 24 deletions(-)
> 
> 
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> -- 
> 2.37.3
> 
>

Reviewed-by: Richard Cheng <icheng@nvidia.com>
 
