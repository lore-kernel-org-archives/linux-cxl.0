Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012035.outbound.protection.outlook.com [40.107.200.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F974BB5D5
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560335; cv=fail; b=rm6/gttpGU+iylcstNnMZCCz/2P7qxgkpnU/2WLJahX4C8c2ZTBAYC9XS1FItbSbYweVu48Bx4SQUquRPq7pOMddh8lTYHh+sgBRd7hoPQY5YoJ2d05e35jkip73Z1p0SxGLfxmnsmTjvmgfKhoN+jKkFfSHpumczElsFVkxFrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560335; c=relaxed/simple;
	bh=36MvdjHss5Cu4BMV+Zypd4r10E4MrQMGcRatkMyo5c8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oLa5QWqkOS3GDwXtwcYMb40zRe/uAECERgCiKm6iHz98uN7wc15Mnu+cxxQm63Jx7/babBZzKsqe40TKlyLPqmGOFcj9HOKca7mOwVA9S3HjQw+AJn/dkrcZdLjJ84Ip2uHLmUNWFoTHIKioVeEntK0Dq1w9ZxZVQE2JpJZDPU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YfYjb+pE; arc=fail smtp.client-ip=40.107.200.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YfYjb+pE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl2I75Ms/2k7fOJiZAVIQuYPGEdpcg578KUwLKL0mhPqq4SFfY17AgbE3W2THmQJLT2hk0BnZbmZi14x/OP3wNdJp7a6fwKFz1KZ4LtLbRhvea6hZCiukXVKnQBkuWNKv74bXVl1loKJIUhMpWAIPC594Bo8ESoDZGiBylCSLUWMAAs7TGHUpsWMEktlIBIZnpSN7M+2T8/rYM/cJq0bfCQOMikU7R9+4Oe52oBF8osOKOUsyjLVhMzyPywP1Q5WWxpmrotOivDK76GVJKgSuoau/s9bqDo2sQblLtqJArJ8eI0d+OqYM82QbQBFDVv0SnfWkKUj2rUUMDgCYM5h3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpJKapm73lphbiHltqkjkWrNbHy0v2BU6F7JeWkQXuA=;
 b=P9kYoLlcnuE68hMrzZC2pLok5qCweSLnixNpiey3UXjlQNl7VJ5k57Xi/63rNicXWPBbzECBwKOLdmCMGzJnwWEAaIJ2vutOYRLrH3u8MKB2X2b6bsTRp73KrLIj2SzjLGHr3Z7Q0BB9lWjEcNfeSemSha/35iv5XEs+0gaiO5qHoSYFoSTM18h+rnA1dM+GVP9Ra1T6as25U+z1bmIEue+cJo55pdpcCpXYPSxMPfu4WxgxWrnXtsv9f0jwMjeEXXRc7QO51/Icv/eW+RD7Xc6TkSySi4fRjAXf24ucYdlnQfH7VbAf3+TgRMd6vLWQPORSZO0tLYwQYppwAXN3Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpJKapm73lphbiHltqkjkWrNbHy0v2BU6F7JeWkQXuA=;
 b=YfYjb+pEEK5hLON1XOSn1E/Ym3OApUnbYh/DYcm/2RG01Liyctut1dN1KnQ7ACWmz9bKa6Rph1AXqtTijrdH5SYsgZQrhE20xj2ZnF1wqcT3rfRUCjSYvkuUlOJ+CWQcXMlrtmWOxyKHiKuSzSZz/vC+FZRbh6msEyhPzYskEtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.11; Wed, 16 Sep 2026 12:05:15 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 12:05:15 +0000
Date: Wed, 16 Sep 2026 14:05:11 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/7] cxl/region: Warn on user region position mismatch
Message-ID: <aqqF98W7MnnDTTet@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <1d662e3ea78ec8b05fceb500f04e69ee9f6d4a72.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d662e3ea78ec8b05fceb500f04e69ee9f6d4a72.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: 3488eae0-7de4-4cae-4ece-08df13eac4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zo9B8XyI0mzjNVza4KcuBVbvk2BmERA9qEaxIOoVEbNOQPhoHysTrvEFBIMW8oPA1TetU7hQ0C4ztt4dS74oTJsG13eCIJl1j6lPoUnl4/MZdU81/8N/k9Il4YglLxKzjKaJod953zFmJPHCV+Vb8ildFNfeRmL+xfptGJbeefygGOjbjAwh3zT5V2UsswhSyXDhYWDhFOo1QnrAt3/ZUYu1vLtUpoS4RFgAZQvX/PRmKSEZxNQStBffVqXNzQ4IGdAREuyrRPOjbp4PtvqK/7+1lHMUcARLYP4qQHsdUeD6dShBJd60Zneof7P8pMt0WAFzFzTxkqSva9gatgNuDLQNfZXo3I4tldLP6b2fIlTM5Y6/Q4hvpNcRP1Czm2ZV3eHFbQ4xRefGtzFjaO7rePn0cGMh5YSMJv4gvEvRMTmiUGmg1AOF56DHfzAh/oDRTctPZBTb3EmA5QuJBvOhw99ffJQWmrEKQBvAGhsVxVOOGhJNaFqyIBexkVlhrBmRqf5UT/172xyw0pWSiOwb9JKoUMDMsjuHWFiM9GJAWgkrrkIDeurAO8Ax1DKDLybdhE1Jpa6fSu/c+HY4auW5nWSNrR1UDrpKSerbAWvXcqNihu41UZ1W9JsoR59/8eBiEsLmsOf7Wj06F8tAeUwkVzjoUkKqXnroSR2lJRBTsrQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UrlCP1qRSe+SUeLQzK8A2xKrfLg4/MGN3VXR7jafV6ORzZPTaKnrK02G4bNy?=
 =?us-ascii?Q?drsQUASY3bFr/i5zhiIrcrvNld9To42EmvxWoFIWFlXhhDj/dyEAIVbXbTc4?=
 =?us-ascii?Q?Zzey+eEsqgs8dCvzWZVrQVoE/4Xs4rv+Lndj6GTonkjK2r6kxaUikc0nvuxs?=
 =?us-ascii?Q?sUzotjDlHn8ZIczvD86gcW9c09evwvcJxrmkXnpNryyMegRbO8J+7hcAO4ST?=
 =?us-ascii?Q?yUN5FryN5yAedLoerIrt7/CsuFg8Jt47pkaayO/eUKUbZfxjCuBYi2ioEp6x?=
 =?us-ascii?Q?8S/n3yxAda8hHqKq2rGWCXtax4kco9tSoNQu1B/ZYWFvfueyJzvg3MSJfjRw?=
 =?us-ascii?Q?6OD9E6PeQn0oEqD6aXTjCm11ehjXKIDjZeOFyesOWu4hG2Gnyqzx7kmBEwpb?=
 =?us-ascii?Q?4yTy3FGnlIN4vPWwss0XOE9aUnbpWZqkUuPPC2sgagTuk9beDLyAYfXtTYkF?=
 =?us-ascii?Q?40f2JWuAa80wnVXtbEf5kRh103rksSa4g6abhB+wmF52XFB1I5RO9UhaigeI?=
 =?us-ascii?Q?rpGChqX6UdsrGo3qLTInF5JkSv8z6xgJdzGbD544z5Ka8BZ9tJdYq9Aa60sY?=
 =?us-ascii?Q?32d9CShb40+cZXjRrfmeZNfEIk2ChYKrQlT/0b0De/JuHUQbnVV9BMQgCNGu?=
 =?us-ascii?Q?WRK3FTMilFsbx8lxTlAGTQgdj3qDYhiRzC2vjtngL4LSbTomJOQ0z9ytmWs5?=
 =?us-ascii?Q?cB9udDH1NHe5MX9elZZTGoy3pkJnpObvc+1mhuoYUJ2uFeCE1KwempSAZwB7?=
 =?us-ascii?Q?mjaFlmgeBedIJI6iSAnOCfX/kh8OPfXq+MwtDaiwI6iZtrYtH0eap/aSOspl?=
 =?us-ascii?Q?nV5HUcbltXMtK/ll5zhxr2KgFG5zDiqNqBXIGmNh0n9hoBz9NOyyw7bbde8H?=
 =?us-ascii?Q?eYs9MV3Q0BulBxmA2nOK867PlG4Kibv0Br0DUXePuoqJGtCQYSKUBn78b36V?=
 =?us-ascii?Q?ZlTr9paEdRLAwVVb8EBS0nLfgvGkIOgxCn/v89k+Mas9vo1MQUfAwfdvuFMg?=
 =?us-ascii?Q?BHNSnRQgj0eP8aIiZuzK0TqU5HWT7IO8QGIWEwi5pXNmhKE5PVlp+teDVo/y?=
 =?us-ascii?Q?Vkb7G3MmtgTJWYBVDU912/LiDVs0n5FyKy6oifaCQnGl0qMpTgI8kb/3Bu+F?=
 =?us-ascii?Q?KK7xzHRuD54Yc8NVrUmLJFyba9CvFER/0jcCPYviWxj5l4bdhi/j2xEdkm8B?=
 =?us-ascii?Q?KX6KhzXtMr4r2+czr41jg90B/Vx3Fh0GAFzrei8kMptqsYDfR92SOdqlejoF?=
 =?us-ascii?Q?mAZdbRSdisMlHAN7+qNhZL9GaDiqmKRigfvLI7Nyu1kw5K8MaqgsC+EZlOsR?=
 =?us-ascii?Q?dTwL/pcBzcaDn1YrWXfb6UWGvaLEpZ0nGt/VDDLV3fmmcxs76LEUSHQCLKmB?=
 =?us-ascii?Q?Y4VrBWiyqzpv+L1lVvDHsFLDpWJRRgBo2u5aKHH+7sqWE2gup/PlC2fC30AN?=
 =?us-ascii?Q?VmjBi0hiKdcSMUqvfB8eT+zx34y+F4FP/qdClIgavA0ABZbVnO5lFtQXIQUf?=
 =?us-ascii?Q?yCU6aUi3F9p89YGNBLfoJG/Hb3nQi+z7c6U4nVIpuwCpGQIb2wSn1tKshsPt?=
 =?us-ascii?Q?x9WzAIwfB5GKS0Rte/AzcKJADjNntZv8G0UO89POfYwltrJHk1HJxCSCZse9?=
 =?us-ascii?Q?EdEiC/MjAwz2db6sE1rzDb+vmfUx0Y1lR0IE5WsR9qKhe55jrI4pyS8f08jD?=
 =?us-ascii?Q?jrzI7vYsep0HyEidMEIwXEI+28Pg8DS6iLi53OmE4IwZS0ZH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3488eae0-7de4-4cae-4ece-08df13eac4c7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:05:15.6523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iy7IvuAmaKFiIXxTu11CtFmBMYsFVW9nXkjxKLIU8o+tHXNBIuxMehaFdAUmY9z1wHO4bWgvBeVszOZ1UIT8aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634

On 03.09.26 16:23:44, Alison Schofield wrote:
> User region creation includes a self-test that checks the assigned endpoint
> positions against the position calculation used by auto region creation.
> The result, matching or not, is reported with dev_dbg().

As commented to the doc, the position is clearly defined as the bit
mask that is striped off by the endpoint. That should be documented in
the code to describe, what position means in that context, esp. how
the position in the target list of each level adds to the position.
That clarity is missing.

> 
> Promote that to a dev_warn() that fires only on a mismatch, so bugs in the
> auto region position calculation are easier to catch as that calculation is
> extended to support more region configurations.

dev_warn() change looks good to me.

> 
> The matching case no longer prints, so dynamic debug on region.c no longer
> confirms that the self-test ran.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Robert Richter <rrichter@amd.com>
