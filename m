Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED981548E6
	for <linux-cxl@vger.kernel.org>; Mon, 29 Apr 2024 12:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714393408; cv=fail; b=L22swRQhtDDmd/tfKltPRjXqh4rLULyJnBw3/XBDVqM/UMJzRWgGZXYoiRgL9RUTejI8xH0SF3ttNWXi0lcXmAVO+a1wosV5AYs5GSx3+U4Gm/Z1mi3OdU+GAR41UGbu572TaGwa8/8NLbj+KvanTtH0tYDUrPpPMRQTDS3J24g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714393408; c=relaxed/simple;
	bh=zKWWWRlXcAd9WvLut/vHLLWGQgUodB/HgfkQ6EJ1/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mieqayLXUc2c+InCcDAxNwWBVgs4OuAGox0fyI7AzHOmfV7U5fEii0Kkc7KI1jb+e2AlO3UoeBLrZlUD+mwCVyxN4Oq0JXCJmTqD/MDTMujYgGtHZ9MEoyc6CnF06jnLw1lr2L5Zj6Ts/5CACBrp3CRVTwCr7WUsN+BPy/0Fv1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vIkUWlav; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vIkUWlav"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzlPK/Fyw6Jlue1lFWI+XbQfQu2Cehg2oURSJQ1NCD9vg6lgpftokEeowN+GwVNLSS8G7AFWy9Fv3AL/HkXI5iOo8ENgN7fzL5oAVEEH5ONA0Xo9YEaf+YDePNwVopPjM8ZEx6xlVFRHGcl2pjLmonwHXYuyE382mbUurkK/5DkuOOroGJddKrof/L4Mu4ilApxzE0shqB728vYzuXctN7hkR69cH2WB+YQrzhH3qqh5mAWl+rqH6AR9iCAODSA7gKaGPERJlsV/Vm4Wn6s+S7C5BEoP+BpieDEInvNPuzeNw7C0sAxYLCLSxfTGn86tK2bVMHrzTgWFVk92HRnK7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zKWWWRlXcAd9WvLut/vHLLWGQgUodB/HgfkQ6EJ1/Eo=;
 b=TPoH2xlzpDHMnnLcpSo0qLjHe/p0Fris3QYGUHat8Q8L0RLc73knMj+VifZA/iDQFbRU0/qLkRrPVe1OUPc2Q32Ql8MVfPyHdw9p6axKKjxf3qu2D+foN1G2hgos5MsWg3WCpgWVdf9XZRydbkU+L5yr29245lXobeWzti1K9vfx059r6HkJMmAlrdMB8+uR0/I7LjugvdrCKPw4RCeQWukWhkNjHQp+1lbM9yx2/aLeI+xwdRnT+lKqNXkjSVRyhQIZVAksQiiLuud5US9V/3IBUMkvXwl/HG/4fEPQeSJq2bc1Yj9fVsK0A/vvAKGoaodrFeFVOyrexCyfPBTMqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zKWWWRlXcAd9WvLut/vHLLWGQgUodB/HgfkQ6EJ1/Eo=;
 b=vIkUWlavmexi4q7iWeLkfne9wEB0BEsD0w3hm3bp5XDXGimcr7MFXBqBf05W/IAi5GPcbmhD9PLdXKVHP8mMGbBB4saGd8bTyfPbuVGuXRRq+Ops7Ns9jh2HFAEJZl0b9+hEAJdKw704ToE7Insco6vGPa78+YDIGPADgSxo4a8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 12:23:22 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 12:23:22 +0000
Date: Mon, 29 Apr 2024 14:23:16 +0200
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com
Subject: Re: [PATCH] cxl: Fix cxl_endpoint_get_perf_coordinate() support for
 RCH
Message-ID: <Zi-RNOZ7OlK6rbuA@rric.localdomain>
References: <20240426224913.1027420-1-dave.jiang@intel.com>
 <662c425f15f73_b6e0294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <662c425f15f73_b6e0294dd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0168.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a098dce-06cb-4aa5-704e-08dc68472941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nkIbsYk6L3iuU21MtB6Lszukr/2WGa98ObKDI1Ypy8zb5qm11kpXInOfK5YT?=
 =?us-ascii?Q?kegrVzKuA/31bGu9wKRc8Z5bnnpQgAzv/VI9bi6f4NPG/jTTxzangC1Gx2yy?=
 =?us-ascii?Q?jubYjbTs1x9xmBrTRLXJ2zjPokXfOr0sJBn4qQGGj6tLuqRWAXq/noii1YYs?=
 =?us-ascii?Q?/vSj8mWRILb3JbcJu7c4VSxJxGDjPqWUVf7Lf2oEO1KWgSyfcYg71wejpXwY?=
 =?us-ascii?Q?IJiv6hF+yE5tKYldYZkgKzetMd7fSDO+N5O3lUM59HaCLqbZG33fs4epciYp?=
 =?us-ascii?Q?kPIo+hCHuHkqD7oerV16TcQ1Y8AH8w3JqBlILM3P9ixAdkABOwv41K9XRh+R?=
 =?us-ascii?Q?9oj7M47F/b1cGJ3EzxtrsYWDJd2CtRh/IRS6v955b4Tb/PKI/GSXyNE47nSM?=
 =?us-ascii?Q?Cu4jwasJ4wlAFr4OXKgNtN+zIGBT+yx8RxLLSCcIeEjmat8BLE4mUX34tKvl?=
 =?us-ascii?Q?rWEoo2H6sRGqPsELotfuLSEaR5h3KpgHwvQo+dvGjquHZNxwzuBMWNh4fla0?=
 =?us-ascii?Q?nO1RlW5g1PgU6g1/SnJ8ojgSzEV+lBUjhSuT597/evwMsk7Fg8QSWT+45kJP?=
 =?us-ascii?Q?sENAHLGOeKtCXCkzOy8l7fWphRD9Mz9CIY+7uJqXTMMXsEYcmWzGX5zPKeVM?=
 =?us-ascii?Q?tUpnFi44ZNQzMROy0jwEdxf+EX6dFgrFH5Z3oihTfuihpunQRDGxfJAUbBMm?=
 =?us-ascii?Q?pwVLw3DXAqu3JFCKYQ53jjYHKtUb6Zk6srQQoZKpDyakUfrVKzh48zXydEmk?=
 =?us-ascii?Q?GZnUfelux6syO8F+bDnBDCXwugva84J1+I/A7radLa3ShdMBJUZ0hnXhQ1dz?=
 =?us-ascii?Q?CdxrURrWBNxfhWh/i0JB3O9XC8ONx8SFUIq1OqVlzCQS94gvF9/z1MiUa83A?=
 =?us-ascii?Q?VcVCflEdDWN/r6nxzW0r6EbbR35BAtJ0gB3TRLQuWyCInJ0BLRC0+mCP4/nb?=
 =?us-ascii?Q?JfTdiahM+ENpoZUscjrmEaxd22s7TahN92rr64YhjUpSHqqlQ0h7Ovwm7mHH?=
 =?us-ascii?Q?or0cVjZsY1Y2KG+BXPeyXi79THARkVTub2VQjK+iWfH/C6nG52ZgK0OsD6Qr?=
 =?us-ascii?Q?7CW2CzDitHxzZ4g0LHl1oB+Re96qBM1I3CVG8hkTsXbVVXr2RElOw4oh4tBA?=
 =?us-ascii?Q?Kssjq+PCkyrtip6+DMZxWUP+faCfLcu0QuhAlhHrStabmzBOLwsnYRbsMNt0?=
 =?us-ascii?Q?l56gMRDZY6RbZl9BwJVylMbmscH7bFfbCeufskv9goMu46QfK3UqrvANYyML?=
 =?us-ascii?Q?NzEfEQsIeZhYh59JyW0WFpbQsf+mlXQ6V2QZ4X2YuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ge25OmMWMZonkNIjgIbuI07m6E4Fb2H2ERiq+YZ9AQyhWOkXUVvxZ/Emd3CP?=
 =?us-ascii?Q?XKJxVCp3a0hGaEKK5r6ON3URibEArRhJ7fMb9qILdEaM9NO5CIDpC2LD8RX8?=
 =?us-ascii?Q?z5amR5yLXv6n8eeEsJ88XMD8Mc4tM2rbHEjpMmeh5kIJHVXXW+OV9IRGPdT3?=
 =?us-ascii?Q?VlBiscIeoGmpi7ERZwfBKOSH6ucZiSxuMhSOTNivqFJEQM8tBXHLFCPl908i?=
 =?us-ascii?Q?JbDu0nbldGg2fCCSDV1gmmYIw41LHoQz0NVE156v2h5smO9Yr8XPN+REnxip?=
 =?us-ascii?Q?nOSAddeWuQD1vAp/8p2hGaNnAk22QsygwSm5Yo8pypEBi6FvFNwzFkh6jgYo?=
 =?us-ascii?Q?+mlpFIW1NN9+HkyxfShoPCuytbeO/LE/OEYNy8h9nGg3MFCY1lKIMn7Z71L5?=
 =?us-ascii?Q?zegJKTc/1euXBJH94ZymFYFPZSUNyeQHym/BWS+yVwU+fr6CFmbAtbslGUfv?=
 =?us-ascii?Q?xxuMgFQ79g72/WfR4DMHCtFqGl3fXPTwHNNHbFFFpApgrjx3ilArj8hp4Dka?=
 =?us-ascii?Q?pgemF2Pfoei4RC2V+Vtd0ywsCgvyvfOcjIsJF0JkFP0s3/l6D2sExJroPlcY?=
 =?us-ascii?Q?veCLXWyRtoktJzWdGop3H/fv8xfoMLGgOsgG/N19A9yPXiteF/QZUpI0eLb4?=
 =?us-ascii?Q?2Yl04WmoxW+HrQlQ3UjLvz1aPXPYKehxkaT75/uI9pDXn3zas/t7w3j3WbKm?=
 =?us-ascii?Q?22kwi8Rw0vqBzIzI6PVqQyCW0yIR7E5A748GhMjyueNAzfkA+/VvhPJai6iV?=
 =?us-ascii?Q?v+a6Snwd9YFWrcIZ75m5hMMC44fL/qk5ODDt+QKcUoXDxSCgkQ+gtbp0102T?=
 =?us-ascii?Q?gbPszL64PmXjHk8zNGKrkFIXpdHyQ4Amh8CecQTvh8MIywknUdkdxfvRStUu?=
 =?us-ascii?Q?u6hM+8Bl/mNAlVAmYb9Oi+mXITnTMbhuSfznr2+KA+lLNE93bSFGF6IuLPb4?=
 =?us-ascii?Q?vdk+LV0l+5IlDmfdaelDtIQdSDMwk2yPoB6o9+h5Kiu9KWDgNLJ8mt1HBn3X?=
 =?us-ascii?Q?n8gqHeLD0rM4tqUtmPpqk346iD3wrub5cPSc/qrj7HKd/wu98zL8ndSQ8Njs?=
 =?us-ascii?Q?m3Msu+ddOajC92oS73uSav5WNHHexQ3IkFwmqmMjqnitVt3K3qUVSawJLANx?=
 =?us-ascii?Q?8HYIexIlIFLYOcg1CzRFhuEtng9HwmGQuT4wYL/3pviRLRklbUBQWGoQl4O/?=
 =?us-ascii?Q?lPQPEBYcWqd/bmbbd1s/e+tkOtjwticPOHsELhngBoYpSA/R+sgMWgOeIwSy?=
 =?us-ascii?Q?uvvrV3Q9rdvn3W2FWqSbIlrL+fEcPlwW72D36yNI1R5rPxptA9u/UvUHlJII?=
 =?us-ascii?Q?mT54onQQtWFbInRgEBADaT8Ie4G3YHZeqV4Rm1RZiyKXyAYTt0fOZVQpmAgh?=
 =?us-ascii?Q?hBGsGrhgpweGqXEJ7eARC5UGXJhRlmAfC1Hx9GupkF123Pa/TtMqvUN7WGTU?=
 =?us-ascii?Q?id37GGBm8PlojaGuogZ0/fCh+cB8HAGKeimBjvXgejNejUcFYcbGwxoosDNQ?=
 =?us-ascii?Q?7xcN1fXte7U2oDRpeTI8q3v176eJXvuMdYrPZFIZiqWHjbUBLJr+QBMeqa4g?=
 =?us-ascii?Q?sXr2UjR6Q2KmWZtCOEk=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a098dce-06cb-4aa5-704e-08dc68472941
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:23:22.5280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: et6H1KmbTfEJH0DKprGxMlm5Y7Xijdbk5BTmK2s5/YIKg5PnulHESTC/ONk4GNW/jiOITIyjXcrgGGjjdPMCVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

On 26.04.24 17:10:07, Dan Williams wrote:
> Now, that said, if someone can think of why the driver needs to do
> dynamic performance enumeration for RCH (i.e. a platform BIOS does not
> populate HMAT), they should speak up now.

I wouldn't stick with that forever as you never know, but for now
disabling it for RCDs looks good to me to fix this, esp. considering
we are already at -rc6.

E.g I found in cxl-3.1, 9.11.6 RCD Discovery:

"""
In the future, a
CXL-aware OS may extract this information directly from the device via
Table Access DOE.
"""

Thanks,

-Robert
