Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA38377A97
	for <linux-cxl@vger.kernel.org>; Wed, 16 Sep 2026 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580803; cv=fail; b=N9/atFzTm6uAJ8BKBP4xTdo5A+fbMQ5RZVwjJIOI3DdmgkmQYrtXMmqejBn9DFG3I3WS/vhicIs+qH6RxosXtdc+NjLfrgYgAJJMgvbhb+pQTsC4bNjmRsojSm+nNVXi7592vy5zL/fZonOBvJZFZXhPuyLIFlKObrDvBVgp3oY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580803; c=relaxed/simple;
	bh=Jmw3c16flZbbWLUtjiEH7jadIXQycspdmqBiuguEQC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TPcExOh8Sq2uPLzrfQDFGq6bn4k5eEc8m6eAEAPCoUWRPYA1GGjzWO5SY05hSfACMgXZbX6/5KcxVnCHjTSzSb+0TwGHxHxmat5P1Lx4Rm+d0+OATVkSyAfa4W+5MO4EL3m1JCQAoufSCDoiKOcSDBszxEwGznbvmp9fQcdv9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sG0USqPF; arc=fail smtp.client-ip=40.107.200.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sG0USqPF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYiFS9eFW+AJrZRk3Ay9hu76GGLXn9LSgJBOPFO4UlZQUxq4SCTn4edSroR5OvvOye89DyKyR30p1WEs8358i+M56/yPrF/K8PWucibuM3CFuRrMVMtUeFblHu94yzyiKWzEmz0xOEG00OpbXDVB+QsONQTWJwiV1nTGLADIgRZx0pntaNCHv6/PXdVBUQnDgIxWPdLCelhkeipdDaACLcBkkaOCcgKVKszWK7bvJVcdmZXEWbjU50rPoA/EDogsRB0OluBijgxjsSwndOJ4qfyqXdz+/XS3C4NLpVA9EjcJb0Y2drWb27MNMuQcg643jcE5J7WixwQaDp7U8NBJkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaEyaGioEeT/csmld5KnispfUF5Ck9/KZ6wTH0fzUcM=;
 b=FtdZwu56qUZUYFuL83YVNxTe1K77/Lteft2B1Hp6RpbZp31GsArSLzuhu2vkLY7rSEaf2ulldE4P57ZwuW8HKd/LebnJn6ae2ppjAUMYgb4QiEHQKG/Qg2t0CW4OPSD4DBB2c1iHjNNnzVJpuwZoxCStlwfqSn7pxv4xcB6bAkPbhR+7+irlUkY+FJGeHaXFnN8+WBtoDiTbu9QBAjLfWBQcRZ5Mqw4/+9u2HkLeHNxIbj/YcAEzYCOxawQLCdg06EqqQ6hV8u7xJPJoStq9aVuULQ8hj9lBM7kSN38haoORAs9rYYCrU0R46YdrUCgMXSAY9s8rMnH3jogRXCMoyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaEyaGioEeT/csmld5KnispfUF5Ck9/KZ6wTH0fzUcM=;
 b=sG0USqPFQdK++W8vxfSIsWdie7V7W5DNDTvcz73qikGXCVKRTTyfTgTXso36SBu7om1rXn9ZK7T1Aciz+/b7QXW744XsVcYXSj6Tiv0IT5c5lmhVcewSUhVho3X89HcTXPw2oMGG+w9HvaXPu4KaBngMjJ6+g+peiRDSmYSompA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6085.namprd12.prod.outlook.com (2603:10b6:8:b3::16) by
 PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Wed, 16 Sep
 2026 17:45:56 +0000
Received: from DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1]) by DM4PR12MB6085.namprd12.prod.outlook.com
 ([fe80::9d84:7eb1:a785:bda1%6]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 17:45:56 +0000
Date: Wed, 16 Sep 2026 19:45:51 +0200
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 4/7] cxl/region: Name the interleave locals in
 cxl_port_setup_targets()
Message-ID: <aqrVz6Q1fKnnMv2g@rric.localdomain>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <b3ceb52dfb0da2f164b941adff60d2db6aaac9f1.1788475206.git.alison.schofield@intel.com>
 <aqqpBBtJ9CWYGQDT@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqqpBBtJ9CWYGQDT@rric.localdomain>
X-ClientProxiedBy: BE1P281CA0156.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::9) To DM4PR12MB6085.namprd12.prod.outlook.com
 (2603:10b6:8:b3::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6085:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 257f919f-f4d4-465b-2d2d-08df141a5c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	dXR99YO8lUsWnS/q3l5zfuVH/Dy6vgKmYU1uKJ33HjaJmjZbE4D4gMHLMkDk6d+JyFaSxrk2CqeDzQKoqTW8ZCelVns2fsjhmXuxXNx6MrL7wrVSRhZR5L3ioNqveb6O7jh6Tcc6vHmMq3A2gwcdZ41GOd4UcO1UpJm1imu4yWghY9vXXoAnMCoe9NL9FQBvPOTg0gOPgoEVnfqreelmCGNREicEktyl34uO/Ai0GVcspzXYERF/bcz6itDfRSDc8xjpLaJAsX/Hx7rkOhNfZR6NK7BZJytMP3bvo+gaKWNj/N80tY/GQ0brQkvDPpAbB2yUPB3ujI9Pev+m05TV8MJo1Y0IwuMRPEKlyDVvn01g8q77YFRAkIKgMxL94Pbwq59m7FnfdnZvHhqBcgPQXXTII4vBWbt/jHTLrdmg2i49+ZDKmsfkr/xUmH9DkFTGNNeoMlM1GJC/2ls5AZU4vc6foyzHMbcXR9pU0u1L8N9Cz2ATG8Y30Rv1xgq8UU/VzbQU+vh01N/NxTSV8weM8+TZXelPrs4TsadrRZG9P/JT704U7wR8GV+u/mJlNqP2DqclL74HW699m+8ow6A3sCDM81kBj5YTi9Qx/JDKu1UEVa8W/kLcFechButUss1XNfdy6Cpg7P3nQff5OVbVeYuN4lv5zC51/qy1fKbG2a4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6085.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9VOBhWHBZkrYXe32O4e2KEtNpCqPUh7450XJBJH3mvtCFoQ+Tti+9FSRdHzz?=
 =?us-ascii?Q?PcxAGkA5llUTaOWMGGZG/UNIJK9am34ipbB7L6PYdOevew4acRbOIUWeiYxx?=
 =?us-ascii?Q?zbuTfD1piFR/4DteA88hMdbk/H9GSzz6o6FDo6avmU2kCipFBzqDp6oK+Av4?=
 =?us-ascii?Q?BaUk/HtoPc9hhQKnBr9jLOKFD/Aeo67Yk7LUp10Z4S+975bxcNnuRzx09wzw?=
 =?us-ascii?Q?RR8GyKMazNdd9N3IG6ODWF6cpkfIKjFVcUecMDS47A9QkktMHwfdHvwH2xAm?=
 =?us-ascii?Q?1UoxWhe0FXlE6f1k3wJcXRONX0fZhTIVvPJ7oVKwgnAzp6jLUjL7HP1J+CqR?=
 =?us-ascii?Q?fmJvJ+xCEyyjXqa2oFhJFYA5WJZGBmShPaBQ7dnkdQHTeTzS7kfPz4panHgG?=
 =?us-ascii?Q?IQ463lA6saMAj72kzjWmgTIvnoauaMZoY0N+w4FcFpBcnCdY+D/TLQgcSCXN?=
 =?us-ascii?Q?JL5DAqeV9W+bW2Hqp4eh/LXTQjB11qD7e6Ew/FqZznwpxMYTYEGKKChE9laR?=
 =?us-ascii?Q?3yDkBk2svICpjhBD43s/71ZP4XTxp+Mu5v+3z24eL4OgqzcUpyRZw3LZ9pO3?=
 =?us-ascii?Q?zT251A+V3Quc02W/dpOkni8pl0I1W5PXj+SfvCchzyw7YC+R0niLCMG0zW0x?=
 =?us-ascii?Q?i9CGiNAQzt57CGKgYXKrnDfihekmbaSiEsvdipN9paFWeh+jpNkK/EmUZ7OR?=
 =?us-ascii?Q?7d9ySUhlsIcgKlhnHWZSfxmBqE3LAhFm63XYcrYsedil9XxCjWPl4olFKVCN?=
 =?us-ascii?Q?Uw0cBpzbLFSEmbGT2kSnP5POJg8Xt2ybILF5JnkTc/4bunY7RFEwad3jnpmo?=
 =?us-ascii?Q?3XNHh90RYWFsQxOEiGC7d7O0xjEa7DmBamEDcmrHhWpXdkgUwcw+HusMj6M+?=
 =?us-ascii?Q?mqdjFCadWfijBFuSpp4wlgDBG9WxG4bhkwyt7CqfYi8r5PEBPZNPjFWrUDo+?=
 =?us-ascii?Q?NSby4UqLkrEffSy+DE8cnjrukaRqljWrQgBR2wfrtw1yxwjfUZhTJqW+u+Lz?=
 =?us-ascii?Q?9wyZ8zJ21GwrOnsptPsmjmpQtbUlqBVMnTUatRHul5vpxGSCUrAZS9TI9w1m?=
 =?us-ascii?Q?BM1Wm3+fDX/MATY58mF+BzC/ePY4l3IktiFjszAqX7c4Aa6Xs9c0QV+r7VwS?=
 =?us-ascii?Q?NUMm6TzQFXYSGvDSYx3ieqdYFQHtet0pGBoCXYcSKOWCN8oHvdAD7Bj1KATr?=
 =?us-ascii?Q?R8wY+3Lk0W3Z7oaomn52dY7DqalTTIFoZaxvKgeMCC/fEz8q6Al1WtGyAdSY?=
 =?us-ascii?Q?j4ksqcm3d9ykJlZhWiNlHd0mQlQCRmy4jnZla6IxRqqdBbdl09w3U4kC2eLm?=
 =?us-ascii?Q?c21rrIupgdMt2Ul/5pueBpMUoKtRKMQhXfFhRZ4oPcU/A+e8CLriJ7DJ3Tiy?=
 =?us-ascii?Q?MGxbv1pl+uIn1nuuGgN77M24iy/qYIsuNeVBeMZGYefGAF6WVY2UtueE+eOi?=
 =?us-ascii?Q?2b2IyTaxncBRX/KZuyfF1ZbuKDcUAOxlX8utnqTpElCz3dpHTPy7iMp7lwi/?=
 =?us-ascii?Q?9FvG0CNz4Y94IDShtVDyuaKBSMsZ7BUqEGT2y+m0cm4a2hJl61HYrCrIhqyc?=
 =?us-ascii?Q?aiyTb/HpzZT+gm8Awnt6w6bmu8sDaSyZgm0iw3N8QiTdLa1Uv+XAfpjbVlhH?=
 =?us-ascii?Q?CraC5qzSmeUUQc01HRR8p1j7DK+z6I079je6Zao6McfeyYZGf8xWyKArh7r6?=
 =?us-ascii?Q?6v59/InPTrOuzVe1wRkMZ7V05X0WB2Gf9ztrojzmPnWQ+gMt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 257f919f-f4d4-465b-2d2d-08df141a5c73
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6085.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:45:56.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SBG3YLm6V8XfV/7wmNi2J7wbWyb/lKUHGYcIkav+JMm0uP+IyxjOQbTG6ETIJIRy2P5IEB6TpmnMXpet+Voug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

On 16.09.26 16:34:49, Robert Richter wrote:
> On 03.09.26 16:23:46, Alison Schofield wrote:
> > cxl_port_setup_targets() derives the interleave granularity of one decoder
> > from the granularity and ways of the decoder above it, and takes that
> > decoder's own ways from the topology below it. The values from the level
> > above are named parent_iw and parent_ig, but the values being derived are
> > the bare iw and ig, so the reader has to work out which level each one
> > describes.
> > 
> > Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> > for the level above.
> 
> Aren't my parents my child's grandparents. :-)
> 
> I fear that does not improve it. iw_up/_down? Unsure.

In the code it is finaly used for auto-config checks or else for this:

	cxld->interleave_ways = child_iw;       
	cxld->interleave_granularity = child_ig;

That looks odd now as it is not the port's or decoder's child iw. It
is just the port's decoder config for that particular endpoint.

> 
> -Robert
> 
> > 
> > No functional change.
