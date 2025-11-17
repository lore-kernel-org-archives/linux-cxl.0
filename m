Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012025.outbound.protection.outlook.com [40.107.209.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B936F2627F9;
	Mon, 17 Nov 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393615; cv=fail; b=U/qQvlKZwDIwYWFj9ffEqT1M2v41Djj/Q8wLSaBMss0HSkX92ShMS801pUT69QM+JFWZDgB+BQ4a/LeyQCVlT06qTHbrDqia6KJx14xnIDTEN1jomBKXo2Ij4u7oQDrZh/FhouFeWm9CLxh7E447OaxVsYyEtALSYJ99n6D27lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393615; c=relaxed/simple;
	bh=87v0FneceCfnrAxovlkwMC0h8TtD3CrgUmEWbC9dWiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iNuUI0OFau+Y/QHqFaewXdNsT5wNroSZVLfag9I+Bwx4R6Abh9yu26MfXhMlcKHk1kelwui93JExe3VYHseCXz1EPz+WFcNP5o91gcdboLz60r7axvqeER04ncDK/sCdGjvmluYccNrWATmDAgXtlhCBdFSh5zGUgUH+FRk8tkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S4jmNBY/; arc=fail smtp.client-ip=40.107.209.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S4jmNBY/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xrjT6ms1Q5ZbP+RixJ9L/TvwpVZDmgUzLR29VIt5U/Zu98n+HJ9Bq5RbpfYTw+apcpxYiNy5BsHKX88clvZsluymoAQOp9zolBrnLaF9iv7AkadnK9EcvmHl7d6kCtcvU+lTULSgqk4pxhfdL5QY9NHtxwXm59C1ew7hqE5d9yIuXSspmORcMn7/i/cJSvO1ri8YNSvT0czoe89AWAqKZ9nVTb+sAKF2JsM/a09hSp7/l1zsVdg9Lq/2uvdsqpcxzPCtDZVd66ZybMjf0/TwglCfzD5Wf9phSIu73AcIODVuMUGqbxJIhaHifBThVJm+lLD3Dn8r/WczcLg05KVhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87v0FneceCfnrAxovlkwMC0h8TtD3CrgUmEWbC9dWiY=;
 b=OB45ITy8KxMl02eb3BIh6b0eS+6gnGNYtXAoUB+FUuifCke+rsmJMO6yAz5fYB805IaJIq0TJFSpqy5YGo+ZW94KcawWHQ8XCVcJsOLFJh63SxHHCUiPVJ0pjaG4IOGRc5qsAQPMwAJ6aD2WP7xH/Ag98p5I9BiKeXY7G2EYFvGkLuM8gqM+TOh1yKEyXb2D8Nlrvzbw9R4SyfP/wJ+U2XNf3bAar0MiQzVWbWHVyZpin4rWKHTNo3kciNTfo9Tj0Fo/ihK/8Ie5qu2ki1lvBkahK3+pZWYQu6SW8d7mN88GAPKbCldYK6jap3z5Bgmx1iuB7n/aUSjmh+TerInyoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87v0FneceCfnrAxovlkwMC0h8TtD3CrgUmEWbC9dWiY=;
 b=S4jmNBY/VjB8ytHsTpU53xtU83PqxnKiw6IEwbkv2fjkD2VXvz+9apvbIKbdo2JQwuLlC4lF5VtX4AOI3bocAoPZzoxMBc2bb5mwyvvZmwz/9Bxui2ZJRZ9qjoUV+VBFlkCqsspigPN/4pKnPlfl9aG1yffDu876zzsa9M9IF00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 17 Nov
 2025 15:33:31 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.018; Mon, 17 Nov 2025
 15:33:30 +0000
Date: Mon, 17 Nov 2025 16:34:02 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 00/14] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aRtAap0NsNElyKEy@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <aQonCRITOLOH0cG3@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQonCRITOLOH0cG3@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b5c189-8c7c-450e-e056-08de25eea943
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IVr9JpfJBOhDWEQO5lml2FAGBxOg2GRsRpa56MWLp00oPGAMh/Nwm4L1SZ7c?=
 =?us-ascii?Q?Yuoak7DUEOtYWbcouRfggaxAW+F8OB8YBBVMTqBI/jiQmDWeBcNQ73J6Xja+?=
 =?us-ascii?Q?dhoZcZj1epfmRloFptQgEjhGeiQOKiYlnfXpKWsY76waNDO0H/sRYN+oyZiQ?=
 =?us-ascii?Q?ESTsr+ym9ubYJG1mXtBnx1rHVuS/7xrcVI/h0Z6pUmwVd23u4ZbPu+0KFvuC?=
 =?us-ascii?Q?Eaff65C2DNL7XDvDJ1W8AXzTxLzoikuW+CjIoN5ZoMlYpDUJgodvm3TmiDca?=
 =?us-ascii?Q?p5w3/XEPY8aays0nvP+mDvZLvjkq9DyQrpkFFKpq+LqaDVDz8z8Ug9VSMFeU?=
 =?us-ascii?Q?h5XXnxCg3bK1/KrR/mSmXCFvjt6SoKViVFBwlOtFO7idhOe3AxxIDWjiKt3Z?=
 =?us-ascii?Q?JkU5qU5UI+M8BF7EnvhzjdyodzOif8tNYwaDBcz3/5Njz83vtGpylGZIe2Lo?=
 =?us-ascii?Q?MEiOuj/1hZq4KtOoxoR+hatUVeqVLPgi85ZNcVK3qPQ9JDf/E6HqP4sZvbC3?=
 =?us-ascii?Q?xkutM8xrKWhlgpE0IuoT58/fOp+EXbS6mhxeZq2DKVlLLWdMNmGDWof9guck?=
 =?us-ascii?Q?uRjRq0N6jos4j4OXcjU0EhfhOy0h7DHjOJAUt3BStlYvFdy26LMvgr/ddQgz?=
 =?us-ascii?Q?VDLiCKSpmWCqZavaNpdO8WKo/ADvaG5D0TujC+uESsNMoNRLB3JWVNpsKaOf?=
 =?us-ascii?Q?FQlOLbBbr2SeV/s00sjiaA2bIBq3JbACj2VmWQkWF5mh5YYWI/aES9bgVRmk?=
 =?us-ascii?Q?Q6mXBOFSIBbB9bGrxJEIQxPFv+KyDA7ZkexdhMj4LbkgT2l0waH1/Rq59p2v?=
 =?us-ascii?Q?AY11WwbVMemhhPausHd5rp4lC1jj2uuYGk6iC89+RxA+zg/TYSDe9yEx+LPP?=
 =?us-ascii?Q?uh1cAHT6kdeKn4V7Q+74N560x06jknt070H2aaeyJBRCCp+7/pko40dKuV7i?=
 =?us-ascii?Q?RZU1SjuigFypNpEquD5RQyIDt8xmseYL9tCMGhGu022P4ABDwlXXD1iCEMJ/?=
 =?us-ascii?Q?qjkECcrqJz2qV+5a3tucxqFtyZg/HKkdkA5dPl6Ds8cMfMsYiy29Ozi3B7K3?=
 =?us-ascii?Q?1aEL0s+vQRC1GPPGJ0V5xo2Qa0rvgQWJ5JZMLPilkUb2RRONvBUBJUS+Je4v?=
 =?us-ascii?Q?OnIUAVP2O3jqzavWJ9F5MaHLpKLg1VpguaRU7wvZoSLkW2J1X9cXyzzLbMci?=
 =?us-ascii?Q?TBLFHcpR0fY99zDvcoptviqBnt3l15U/9ku+OEJuJEAj4+nrMD6VarvVX5y9?=
 =?us-ascii?Q?R72QMbfnZ3Pz/jpaa1IYOFMX8ZgiTHBEdVl422QGc8dx8O6JVpSH4oVCVOJ0?=
 =?us-ascii?Q?2PwM2HPPRK71N+zroLBfZDI+7dzYt0tAodkX/GemXViH8GDTYfaH1kKm/cdn?=
 =?us-ascii?Q?2yn4ghsyHd+64ag3+ZrzN6/dg4fe+DygA3Z8pH7IPGBQerFz7A6HZeDILS05?=
 =?us-ascii?Q?xcUmhuIbOrcZF81Dq77Z+7fAcSHou0t4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFPoGYj8NOA5K7pfMfAL3Al+2ObXCTzLsF01RdfeCAkCgdXnA+MvxTV0rq1K?=
 =?us-ascii?Q?7MH37s9z/ZVLjd2h2bvEhQgXseZQLgXdpVqh7fuUuVYt5aCQUVEeRJZlGec8?=
 =?us-ascii?Q?XMLHeNIZn9mItx6IcjlVtTZg+hCrrrjgS/x5JLM5Q0Ce1gx00jxbHSILSLFr?=
 =?us-ascii?Q?W54LBv4/hxORoGBY438ua9MJRU/bdSh8j0addKvKry8OfOWE7jYuaGjMEnW7?=
 =?us-ascii?Q?hYlVnHWXN2sbyYjhC29xGhc5u8MDtqCta28zomUstNjNWgthXO6ELTviSZKO?=
 =?us-ascii?Q?nRYDEQkQQ9ijvbuFS0A0/mUAP1ZHEzGz0HXngJdHeJChUFDypCGKrCdF1CzU?=
 =?us-ascii?Q?rtpz9IGgII2da1zeQ/2YRhmb9KjEIaodsHPqeBSxenueHfa5lvQ7WRAVL8tw?=
 =?us-ascii?Q?uOaMWfuxcNSdYgw0M/VGbqpb7IvDuIvAb22XZyz+qqbNN8695ZG9XxNw9AF7?=
 =?us-ascii?Q?x6n8Rbk9sntqc6kGJM+1nfptD83+qxXUlAbJa2q70OBsWcQcfNg0auide34Z?=
 =?us-ascii?Q?vcY+7WUxEiB8QLmb1kSuuSSQuu5wETBFhNsGio5OROvW5RwW+Mln6T6qPbx4?=
 =?us-ascii?Q?QWD8ErUstjtKKAGaFOAvXnPMg3lDSRQ6LhGVmRV3bzcBrq/rEGVtp+4mD+LS?=
 =?us-ascii?Q?UW0HpWnmmg9l3nn5fG5Bb0NkvvrEZwbrGnhlq1be1mAx+R6egtuVaBoFA3Bw?=
 =?us-ascii?Q?Zr3HXNLz7j9Aeb1CrcFve6ji1cErpeXPS28pBpa7YrcVWbe7RI8nqV8D4+C4?=
 =?us-ascii?Q?36ev4Ttk9gZ12GnrcNu06dkpSZsZu0QwQF/qrMfpGZ9FkWA9yUEoTefoPq4G?=
 =?us-ascii?Q?iVpzvWZ5J9fekDRxNJ7E2eKwX/wMqD1ZXiZbHJTi2I7HQoPKhIwPWohJtEtA?=
 =?us-ascii?Q?6EdJ/up54YK9l+jNqx/2g2jZkd5e3sne5Y/6lD0xup0HLoxp1HAEa9V0D3ab?=
 =?us-ascii?Q?evRmmzMA8VTRJpvvQ+kOe545zbPvjv9vz8LbO5I3KZgSzVdq72OU+qzZ48ZF?=
 =?us-ascii?Q?2586dreK+C1fV/RJWnCWoUIUzBVHmIJF5UzRR90BuWiR9e17pqnTl3luKvlU?=
 =?us-ascii?Q?GFWrxmYZbkm59WqYxrQvjEpMLfKaQUJl0D0HriyluaiCFv38mEgRHYkmfPPY?=
 =?us-ascii?Q?94YWNp6G2uaWyWkujFaA6VL6d/8X8oIHt82ZYDTUEcbDcP3fKxRjzNfcfJ0X?=
 =?us-ascii?Q?tpFgDVE/JwxH8njp/jTQpFrhpn7YojsxvyPpWEdGRM3XUbLSLGhZFO4Y0JZV?=
 =?us-ascii?Q?fiWwvHsYyQ/5yhCN89HiVv2KQXNZZlu45BGIV7s7Me3jvkfCiFDkQ8rNfXep?=
 =?us-ascii?Q?QxeoMg10drDCBuXnAfhAMirV88sY0gmeyGMD9EsEqfZfCKlcYXkJYNHumMha?=
 =?us-ascii?Q?KJI3d8okpv4PJukvvOmp9SiBMjCkQvWezv/llXOv4BIAMGmxYrGuHRdM2+lC?=
 =?us-ascii?Q?F7TIgJdjydonWWA8BwhxPtjAPdd4iBcYNuYqLGkt4uG5PVB4Cuk8zD+l5ug+?=
 =?us-ascii?Q?/FSJDCzTHu2KGJ1eGzpsUjTobEpmp1P/tBySJPQ7tDciyp+V6T3KkCCiSJ3z?=
 =?us-ascii?Q?StmELYmwm5K2ub1SxJ69/lTpKSieOv+TWbIf0jCX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b5c189-8c7c-450e-e056-08de25eea943
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:33:30.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4PkDqBOrXMDvcPQiVcn6s9LOQzmgWUHQtUkKzJYh63jX9RxkE+l35u34LFUj4uvbYPTYs05/KrHi/U9L0RERQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365

On Tue, Nov 04, 2025 at 08:17:13AM -0800, Alison Schofield wrote:

> > Documentation of CXL Address Translation Support will be added to the
> > Kernel's "Compute Express Link: Linux Conventions". This patch
> > submission will be the base for a documention patch that describes CXL
> > Address Translation support accordingly.

I am aware of the lack of documentation here and am preparing a patch
for this. Though, I hope the patch descriptions are clear and
descriptive on their own.

-Robert
