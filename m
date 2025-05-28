Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2062.outbound.protection.outlook.com [40.107.100.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDD2110
	for <linux-cxl@vger.kernel.org>; Wed, 28 May 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748436829; cv=fail; b=I9u7uaX4f3C+PlOHRJz8Advkaq0/6Dz9kMwufsLN5CPZYAb9FP3zLOomBYwsY5vOAy1AlEOq0JLX4H2zLvQABOJEEdwLMwFFNTd5ft+JPkeaNaVM9pNwob0MzUhqxRaWfzgB5UrEwZ1w37A8P8dCW0gemKmVJ0+KtEGfmPYFPXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748436829; c=relaxed/simple;
	bh=S1XeVMrwntGNkI5/7IHfI548xyZWKbW1zspqE6MFHUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hlj0/yqMtBs7caPH+VRhokNQnd7fK6qoJx3tCtseosYycdy4e+PKa7BYGd/ppfj6iAlNOz6Lngxz9KchYos9sYwFtBD7/J6BJodt2H1jOfUcX7NYzz0W147SEEp1ym5UrYkZNqbOtqfQ1ylJeq4Ldh6ptV9yG8mD1vqlQNCs2/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LTUuROfs; arc=fail smtp.client-ip=40.107.100.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LTUuROfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ud1t/lxPHeB3Vi0KobJUMv7xRVVpMcdlwyDLM8JGdxHRTuzXUGR88LP4HCZtFCKVQbRKXaXQPaDMM4YacsSNOmzU20O9q/o2HitIGrlg13PiGl8cLwh2+WZ6G0wUvk/xYMT/X389uNeNmUTlgxN2M6sgUEpYDha3NouiFFLDnB1LCk2R0RQTTd1ueKYl1p/T1D6KQnm8xbR/xdkUxwdAaQNt3Mj6wZWUbBBrVLHEJR8jKwyzuE/SIv4JiqIT7oyKHlvwsskXFGihPRsQczBXGGpAUtJgzX3PmyhkejvJklvJ+qLKXzSwqDhtiwWxml21g4FhfgwwPM1HvbryvG2djw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JIEZBrlk/RoZAuU6F/TG+8C30UdwPjV3eFdmNywvpI=;
 b=S2TJ1Bjdt5s2Q5LVoEjLRiC6LwFKX3NIZKDgFgSW/+F2KxWVO23xshDpxW6IlS1MfLNN/8DfP761VnLHt0rplgqKosIlehsDmQR7H8WUcq+ZpCboC0hcqFA6UVr72F5DK5rea5fRu7rxIekHu2GczkR6uKVY2QoO+24zMIOii7qn6txdOgQkhoqrgMaOS/MmDjBzq4j3qxeD3xyfQw/H5tdop8gr3MEha8ATVz159PnaTrgoHGp2//uHbKp0utBEWBMHAjNjCJ3sYztD+QJDffCWIY5wPE1y/1FnRoXGIkmNHORDZl9OEwJXcVPpxHW6f8fMyFjGeI2LaeWfn/8Mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JIEZBrlk/RoZAuU6F/TG+8C30UdwPjV3eFdmNywvpI=;
 b=LTUuROfs71VIv6Og5uWoqwg+CjPC3YC28S1IivHb1M7XmUVG22FUOQ92ovRvSiSQCS96AxQeVIbwVWPf3V95iKhPZDSDo8etHGCgVimAe9sEd/+Mw5GFS54Sn7t1Z0KU6H35+e3AxgvW+nUna0/XwnKcvZCeckUbLXKRCRqfvwk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY8PR12MB7171.namprd12.prod.outlook.com (2603:10b6:930:5c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Wed, 28 May
 2025 12:53:45 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8769.022; Wed, 28 May 2025
 12:53:44 +0000
Date: Wed, 28 May 2025 14:53:38 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Gregory Price <gourry@gourry.net>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 3/9] cxl: Separate out CXL dport->id vs actual dport
 hardware id
Message-ID: <aDcHUlKYjKXIZEDZ@rric.localdomain>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <20250521183443.3828320-4-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521183443.3828320-4-dave.jiang@intel.com>
X-ClientProxiedBy: FR4P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY8PR12MB7171:EE_
X-MS-Office365-Filtering-Correlation-Id: a49461f5-586c-42b3-40d2-08dd9de6ade7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FCRA0Qv+he1/l5lmIGI3qTH+BdX878GKI9psXvb2d63nH1yXz+4e05PS6dvU?=
 =?us-ascii?Q?NRD/67KZYOSN/o1I3T6KWBxwEvqtFhDaSxwpYWEyyhxXLQaslzDXPeHuNrxJ?=
 =?us-ascii?Q?4zRl5SnTvmcI6PDZXNuHwD3lP4UqfVJfvvxT1eWI/V1LKSH+G6PN785Tcft9?=
 =?us-ascii?Q?/eHfpD7aKGe1o6/sWTfIvvOX+kT2ZsgDRICJxPwzUF/DUBFd7E0N+kjqvjSV?=
 =?us-ascii?Q?CLJ9pxan9B7af/JXCDxO1MJfa2oGfnW+A9v8adyxd07reJjHsMDuiIWJMvjU?=
 =?us-ascii?Q?M58GwuKq7wgryu/g8VQ6Qv29wD0c6bJ7XVvEYH8QwwBHbxCsleZo9vQxRTiF?=
 =?us-ascii?Q?THdi2e/kIYb7h4JZs+pwzaprQN6Er5g0cJEYT8BcuAYacve/2AQKu6TUA24Y?=
 =?us-ascii?Q?VdR1X1P+aN07UBPmDwgPbJo1RmpdfxYRe9wzB+KvnecrUUW7woLODl6/G7sf?=
 =?us-ascii?Q?rHKyal2cdMKO+EIathp2dZSbRbZmKaruen4NF57ZWKy4AFQmBCzxlqLJgw2o?=
 =?us-ascii?Q?uHIyns94Sg9TxXw4tp/kL5GQXkFinn+VxBOEaEglyvMA9FNnIvd2/bukfARw?=
 =?us-ascii?Q?jeXyKblvS73S3Tp81XiQVE2QG1bW1Rf4xJp5kIvXEiGpkYUCd14nR2UWMBO0?=
 =?us-ascii?Q?2UQmSB/ZW7OFjmmTGfc20PWxC94j7sEJQpZMY+bxW35XqVGLe5pcP+Ppb0d+?=
 =?us-ascii?Q?Ki2W2+W3ZrQC2I3VG/ADTZ7sY2kLctTPV3AwzbfgepO8LryfrsL8FSLy4/6A?=
 =?us-ascii?Q?qBCW6uSfm5/HCJzkc8rURECrXYq0OxhRKu+3d3ZphPlk+VzY+94Zqm0juewE?=
 =?us-ascii?Q?iN8GJquKNla735ysCOCt287FKOFsaDuaUp1GO2sxkHzIX/EBpo80TSRjiGBo?=
 =?us-ascii?Q?pdW/2f4PpTq13phqznR/PB0alBkCYXwKzPrM7fGfCywDXdMoiq4rE7LTv2L/?=
 =?us-ascii?Q?GgB2cI05iWWx5UzRWjxUDun1+fM8gwoYNxGlwYAAn9JZmuqHDhvBHlVW7kB1?=
 =?us-ascii?Q?gbytp11TH7IX9Agd7EW5fi6MOzjQTO2le6Ao2LgsRa99t1XTBaREgpMi6sS7?=
 =?us-ascii?Q?2p2R4baNjkNu+OCVF9FoyM38Dg3nV2vTh6BsYxDLTGrG7fKft+pp8hzWQntx?=
 =?us-ascii?Q?cmXocIm5W+pjzNK1LOh4w9trvCoSj12show9cPrmtWjFm1N5wIlKVFdFQT8J?=
 =?us-ascii?Q?7p5hoQsK/ShMlxvKviLKpbh52AujPhB2FCNSR1h4+VeGvfNeOUidfZrGqXuW?=
 =?us-ascii?Q?ftoYeRY1hqQgZFxe5Dj0i3IwcuAmOLtGRR8BA59mnBwABgz9sPn75n4hioNp?=
 =?us-ascii?Q?vDkHoF5vA0PScHK6clEU/uu9rs9rErwIVdo3K83bjW6uctwTvs+dJNq90P4K?=
 =?us-ascii?Q?ST+g7ebwvbEjmmJaV/xtC6bhlSeZErNC2/KtWec53xvL5kGMu9zjMOVcIkEV?=
 =?us-ascii?Q?XZqshBpctyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?puexsxPDg2kgG2UDV0/jTLJRVRbc5h7rSFsN+vtR7Sfz3nYHH8g2UWtd5Ki2?=
 =?us-ascii?Q?7crUy3qu9hii/Izao38WzzWGQTyMCA8IoTuo/CA0JgtCFF8o5fuebTgEFSId?=
 =?us-ascii?Q?V3NoS0qb4w5BCZgWW02XxEfMTV+T3KEQGA016GqnptOvNaX4kPngyRWEX3bx?=
 =?us-ascii?Q?kuJxf0212PgXSay/1akZTxCn4kC+Uklp3WYPKkOXlTE7c0ShwvA7nKlclQuu?=
 =?us-ascii?Q?WfRz9iQDll3ZoeVOfEYvofu2nvOH+my0V8/pWQ9soOV/2oJEIKQO5e8y4F0h?=
 =?us-ascii?Q?ZXI+zKpOl5edplPilv0/JBhRq/FSapPVaD/0F+K3ppKMNsrx8p43nMExre9Y?=
 =?us-ascii?Q?PPRKFdBl2BC6sJdKDqKtKl+BBeTbeQ1lPrvykcmbuZTPNyCyPdjm4/uwvy/R?=
 =?us-ascii?Q?LqCmzukoUDmsxdHfxn7dPwAZBuUZKKzXw4D8wOFBXfejALh6OQTm7yHbOT90?=
 =?us-ascii?Q?mfZ9ggWRmJJneGpXk/PG6zyCY03+YxPRkJ0Nt0J8wzGisglrHzlq8JlbtsE7?=
 =?us-ascii?Q?A0bwg7IL101Fa5CeByLUcsDvF1teHMQ/ConK/6uSTk+7yhkTrVZhhNxC/epM?=
 =?us-ascii?Q?RD7Eh6aauyL+ae0p9e1I7BvUMTs4vFS73oDaDOJ7k1zxH2bVNErEJ8tiUhs6?=
 =?us-ascii?Q?2A0IvNZTQFlbaDayS3PdR/nTv4QqlDw/8jqBYjPWf6dM3Vk0Gh+7kkVUAF88?=
 =?us-ascii?Q?XK3hB7DJB3fpo3HireuYwtReMmcRFIXTL0R2VSYi0rqTrPsOtBxu2Gr0khAQ?=
 =?us-ascii?Q?KqcojtoDdwRmp1DXu7EwoLBPtg4zXGf+vMVkRD5NYeUKxNvcR4wi4QdaME3w?=
 =?us-ascii?Q?gVaknzvxWmQKIdg6/WV1uALPankEuVHgp2cjuAvY/oAMHIkfDcWL1ffUissE?=
 =?us-ascii?Q?XvpgzElR+aS1G2hDnR1WnPVc3A3YDbrv3ePT7GIWwjRlxmkqNBPJ//Lm5CQE?=
 =?us-ascii?Q?qBZs8hIQXgBI/k0b4GMXnscShYgAU9vf5SHnUJK3vfq19K2l/bpLaRp+hMZt?=
 =?us-ascii?Q?WaV5ZmJ5Y1aVg4rJK1mWSMQACB8DbOAVycDBk3cL3IExr7Vtho+y9OwUauhx?=
 =?us-ascii?Q?ikUqZ8K3hO7W2hj6RAxWzdS0YJINuQ5469+T24y5YDhhBQGVmJN/qqIV9Gkg?=
 =?us-ascii?Q?HXiPRr3W96MYw/fS8jijSxfmb13npknaF3cwnHWnPthQeEK/D5tHqcty68C6?=
 =?us-ascii?Q?BU16cszBFFFbWqtM1+qR9rXoTuT9m/tniu8yQ1oD+ec1Zl++G72ZSSRrxtJx?=
 =?us-ascii?Q?VOLZyve8wqakGYZhI66QjK+wJKl7iL9zsNUhOf3kM0EkLdcAQFvYahgsyOUP?=
 =?us-ascii?Q?H+Ms+NDkiMlBQVd3B1XAI54mII6lusPEOL8Eg2/xnz4osaEbiy77PGbmBqt/?=
 =?us-ascii?Q?lNIsY5upLp66Zbsew0IR1iocq6U0sKryJHN97q2OLmIm6LYz1cAD0JaEqvQd?=
 =?us-ascii?Q?Y9CQifqybRIA/2jsjoXqrlyLzU1gqwcnpkwNN3RVUjEbrYu26dpxc9+bfo2K?=
 =?us-ascii?Q?/iMz117ylv9VufxZC+snOUYolOgfT0yt6dPA7X0M1aSglIHh9/22W/859F9t?=
 =?us-ascii?Q?rrTSANOH4hDIG4b5F5XaX1n75K9acEYU47CH1NIS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49461f5-586c-42b3-40d2-08dd9de6ade7
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 12:53:44.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJuvBDcfgluYnw0x/gR5Z5Dlx4MKhhb5yJXjXZ8K0gjpbRDJ4myqw4MOpMrzIhVtZBZ/PhcsYUJCN9WQhKP8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7171

On 21.05.25 11:34:37, Dave Jiang wrote:

> @@ -667,7 +670,8 @@ struct cxl_rcrb_info {
>  struct cxl_dport {
>  	struct device *dport_dev;
>  	struct cxl_register_map reg_map;
> -	int port_id;
> +	int id;
> +	int port_num;

I have noticed some leftovers of the port_id string in 2 comments
(based on cxl/next):

drivers/cxl/core/pci.c:  * dport->port_id is valid means that dport has been probed and is
drivers/cxl/cxl.h: * @target_map: array of expected dport port_id mirror the target

-Robert

>  	struct cxl_rcrb_info rcrb;
>  	bool rch;
>  	struct cxl_port *port;
