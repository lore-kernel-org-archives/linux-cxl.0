Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3FF3E715C;
	Tue, 14 Apr 2026 15:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179663; cv=fail; b=OT1vXk5zaygQFpMpzQRs/nQG3fahceel+zYvyn1pjHjKIGjcoQGjJQcpef5DjwtRoNO+CkB/DhiokPVwgT5ZPwzMKuh01TXG31elYgmOxvj6bUxr4a4ECU72vXblH27hYEnp9iHf0eWZ0R4Wq3V+SPmi60h4iC3H2ofjKskEYzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179663; c=relaxed/simple;
	bh=dYj0RNurWmmuYspFSr37WH54gyDO0uIAd26pgg8dkQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZcjBgUq6p+2qCAjb7K1UtJ/2dhpe9UlRykFBq41xSSWRc5EEVV1IfjtqY+K/Hu1Xubsu1sPZNNI5KiicMx8MZw1Kwb7Jnqh5aMGQ5cIkfigbwc3Fsg7L7ndOAGlHVAkVZDqVyPQk4vryyjYpUowqa9z2cE22XdSjTJnW3TY5bXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y6V9FoNc; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y6V9FoNc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdpLVNkkEFBlFd/fXt41hbMLr4FCvVciFCHCTGM8aPhU4CDEsbf3FZMbhdGT886wqid6qogkLyYLuP2kl64zl7msD3r+VXIA98LBP+uKFp5ovb5r2fO9ZqzyoMdQiHLsG/6CrqQ5jHNj5oI3Sg7xhhtXoIB1wh0inM+oJh/IKJ0jW+RX6ijKDEkyVICkye7QQN3DyYrtQVNQ0h05cygmWS66aY5hcTMiNtsLF2KPD6UWCauFvE+yusoGtbZ47X7ILHOgz2NG+x3SmzanSnj5m+5bBYdkiITIs1xqNpoIARjdbLA88c/mhOSrRp94lCUeBXC1C3Tuzv7n9ECF66vVxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYj0RNurWmmuYspFSr37WH54gyDO0uIAd26pgg8dkQQ=;
 b=UYVKTReKvdUhZmIj0Vt69BuWwvp+HXsHW7Rz+VkWosQmWorPC0oSEY6ncWmpNfrhhyXZvlrXzwI/mIbMRpqeVfJTYNamSM5HZTqAu7H3e9q2xKDyCczVSyD94YUKkspbUpfAJ51+1JTYQ4jbTpXWzdEm6Pkf9lD7EPA7//dXeutvEKwUFLDTKu+m/9y9ddrMqMy8B9jqtLzeXv2jRIpNDQ1Gh9/9xT0fJihqVGAV/8Ddglp3PJbmJ8vknxXbQRT2ZDC54ClCks2beh4zKV10NeukWlauLWM3To3h6OQHwrU/sToN+FCoZE2ejy+zF7uDAYrM8y5hYiShZdIVeUthww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYj0RNurWmmuYspFSr37WH54gyDO0uIAd26pgg8dkQQ=;
 b=Y6V9FoNcUiVd/JhBwCSf5vwtoisAlcxYRd37w8/Mtq8RIs7wzefnbZeM6QouP2b1M1EJZpsEmj0SjSC3jinIet/qWrC2WRwdZS8cl1PZkuf+WZqR68G9bxuMKqagEBB+HL+gqYaYwoLnctYT1mEfCUD/siJTtcHGma8e21OEDlVJAi2gD8MjziGjBgkI7Fyo/Ye1Mmfm78f0tx2A63U5KYDwgOyIo4lrnf275m5h8G9uEebUrFVLoe98lr9LqDTR22fYXYWuLJnbQ3UK3ll+L+RpAHwSck/LfeGfVGa2h1Q6xDD3hsYwhHdwMLMgkGuDCuLah2PpdrKrAak9lqLxIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17) by BL3PR12MB6476.namprd12.prod.outlook.com
 (2603:10b6:208:3bc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Tue, 14 Apr
 2026 15:14:15 +0000
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688]) by CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 15:14:15 +0000
From: KobaK <kobak@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cxl/region: Validate partition index before array access
Date: Tue, 14 Apr 2026 23:14:10 +0800
Message-ID: <20260414151410.3599342-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ad3EjUssy1sLzrr9@aschofie-mobl2.lan>
References: <ad3EjUssy1sLzrr9@aschofie-mobl2.lan>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0015.namprd10.prod.outlook.com
 (2603:10b6:a03:255::20) To CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHXPR12MB999244:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: 079da883-993e-4b17-039e-08de9a387de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2pLkn2vY7MdKczcfWUc7J5MJ0y81LKbIVv1iOA31bXUEZ87pk3YDROje5Wse/WA1rQlUIK8BgRj+PRL8Eu+JVd8alpC98O/1OrKhc7TK5uvDPYyNIjrHQ+raitSwmRG1K9M8fPm1raoLeTrIqNaQ/P09o7gVNnwlToJwAKB/RsIqz+oBvGb9YYMKsTpGmrZ6DIJo6XurMRPAuLwiowX899WMpSXHgF2R7op41ujpZ2eg5fbXpDdI7hiYc3+/UjK2b+cmNRxONQroPycFDcbKBcFasAynL4BDZLrrxOh5xvWmzi86HX7AhFzOH02/BRd1YrNrYmONk5zuC6ja3U+Lg0sqInL+FyFV48GRrG+cbehsF+4IjyRi2cfZnIKQqqtCrfIAcq29aokDuwqhsWSbAEXpzftzCY18sFqLBbSe0mw42uRiGHP/9djUQOAeGJd+vE0sVzpPtav/X4vS50gCXUpoWMz0hbnDDZAkVmYKemKLYtcOVdd6FmyPBAixxwL36TVEzU+2nwb1VMDPPwN6RpMMZ2Gt071MY1y6PluolYmP0GGV+BRzrjUtpt05WviwCOPc8YtuS/6NwmSZ4Li4G0b8GK/fltt42vw5hAX5tJSl/zZgPofgo6ISsCGp6fOcZeJUMcxMBE0yFAWLffYTHHBZCMz79/N/FF/6QVcCeW4oAOOYUprlm3ke71dBgwDOnj+bK0DC16Uv07jA3ao65g1acx3zXBPmyFMTCVzeSNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJu63RJ1coXA4LdT2aghOkg/RGZWk2fbVL4G4wNLeBcjY2k2uQZnc9LwfQDC?=
 =?us-ascii?Q?UQ2AqZ5gjdAxyjybxWQIZPZNIlXq6CcOdTlsOjSQMT6az6KSmJVxfthXU/+w?=
 =?us-ascii?Q?taJQjRhkAGhVwUwS1NPlaNWei7WL7Mo2veCs9Q5KhP82rGchV69wfG04Mz6X?=
 =?us-ascii?Q?WdijzHRhRMwhj+3wYNySQFbXhD1+vRRZyMXM7XoLPkoFLudtwKAlKs8KChD4?=
 =?us-ascii?Q?Skp7DO2YUwARzx/weAGdt0gkxzVp9X6TYV3LNN9rSjvrOBUY/4tPEnnwla04?=
 =?us-ascii?Q?hIamJ/eMohFXfeip/B+Bx71SJOeiEm1t5mj9sXYJb/WyC98m/LYKkQaxcb1M?=
 =?us-ascii?Q?noubyyQKAbRCFS8SKFiD13hFcW1P3wmCyWLAcVhakOrEv9Ozt35hAsmA6kHQ?=
 =?us-ascii?Q?oyNpOqXqtUk7qWEDJL3BYZI5VviE93h1Np6UY3UfOMrkMiFSnxLoiy1egBqx?=
 =?us-ascii?Q?LUfKihxsmHkjSnH/9zntph3tvsqoczX02WdPLxctdNETi6WIzItGOR/Lzu1b?=
 =?us-ascii?Q?v9WdqP8wosUHPEBQmMGH9khaen8gttwnlXZ3zj2454Sw2oS5qsKtdKAmbVC0?=
 =?us-ascii?Q?9SSbAAYztqRrQTN731zm/bC3LFFvH09QraPFJSXy58x9NFaPdAmOuR/FnSVH?=
 =?us-ascii?Q?VHClpGuZIgX/0SyuU/qaoQOoxKVgbiJwZVE/QXSJDIwBhUPDgqQA5V4MKpHN?=
 =?us-ascii?Q?XefHnb7fhrS+3arHqyxQLfNznR2/RSwC/J/VtC5Cx6WHtXbtTconbmOlKZjP?=
 =?us-ascii?Q?URiu0jJbSIHOuBNCYZrKmSSGdz9VpRTJPHykHGFpbHDNWQVtXPuLRP+BC4Vz?=
 =?us-ascii?Q?XoarnTWpe3mANeg+PuahnGvIBrRXx8BInRr2NBAVhsWpSU1k+oWyi3cSvXvF?=
 =?us-ascii?Q?cTwPRkt/KCHPoDZ9zZgLU6jQlZqrtfPk57PI6RxRUHNuqwbVsZG25NFXhExP?=
 =?us-ascii?Q?qJnx2nGbDT8Bd9inuSyWquiYqA/Pud/VITplsnmfjqKd9m925ozCrPBBXhEj?=
 =?us-ascii?Q?MxchDEAbWAfSgnYZ2r7yjQR9ew2K62sHGvl5jEOQ6sRwcXBT8y5fMqhGw5NG?=
 =?us-ascii?Q?SIj/bysyo9jBtufd7W4oGYHgt12+nSyFaM3A9qEuzUINAVjRMloOi/WYcNGh?=
 =?us-ascii?Q?N/Yvidk7tIYeDgNeQeIyhW5D6MhgijlqohmPDfhjjWnj9wtV7xCbUR7GA09W?=
 =?us-ascii?Q?YERyBicvLDtsOVv0J8G8t5GTByg/4EY3796DyUsD7Bpz4dSwTOk173QfunmX?=
 =?us-ascii?Q?czQsncdW1nZ+XinAI7c2UNrMXIpmuBTyTqy2U3PcIJ/egfMb8iHL0nkPt5uT?=
 =?us-ascii?Q?M6mSj9AXamm6rPvFn77dvu70STh+PsVnhywUbpod8RLcEEVrvXMNM/rktDyN?=
 =?us-ascii?Q?z2h4yBvE2ABOk6M9eWQ8klzqxuBst2KOc7WvTcBz/GNuIU8nmEfjJCZoqWws?=
 =?us-ascii?Q?ONJZ/M76cg7UjqFp1Za5AwBlt1yhzPa7Y2gJOlTPD+CQTTh7IgRY0o/0o0Ip?=
 =?us-ascii?Q?+m6z1BsbntvU/fVofrSn0byij1FupzQDKCqc1OGvcn/lBIsDW0BLEnoGpvK9?=
 =?us-ascii?Q?wrUbvYS9QXcBSZdi9jxGe5OEmEelEA2A9gGULSZLscVfU9/TcbgKcxQopK8r?=
 =?us-ascii?Q?k7CmBJEx4vNS5sFWonZOp+XKx6neNtqUz4a5ulz0AowYNBMV4DydxSsChMD+?=
 =?us-ascii?Q?UWNvwSrJfIe7M/Al51HDVqCtQ7BUF0zVt9P4X7ttJ+Ij2R9av2Hg+Oi5Elwa?=
 =?us-ascii?Q?vLAsbPwhaQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079da883-993e-4b17-039e-08de9a387de3
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 15:14:15.4728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrUVHUyM5WUzeH6aHpbyzQjW2LRDi6agebxkGzbZDNYe0nau/p/ueA++ljk2CuUMHrHhnvvBH4joLnJegD632Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

On Mon, 13 Apr 2026 21:37:33 -0700, Alison Schofield wrote:
> > Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
>
> The above tag added the check for part < 0 in construct_region(),
> so that's not the fixes tag. Like I wrote in v1, I don't see the
> obvious tag that deleted that check, else I'd just tell you.

The check was lost during a merge resolution, not by any single
non-merge commit. How about dropping the Fixes tag entirely and
explaining in the body instead?

> > Signed-off-by: Koba Ko <kobak@nvidia.com>
> > ---
>
> Need a changelog here.
> See https://docs.kernel.org/process/submitting-patches.html#commentary

Sorry, missed it. Will add in v3.

- Koba
