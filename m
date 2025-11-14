Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5D30B51D;
	Fri, 14 Nov 2025 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113059; cv=fail; b=TUbXMYh3SXOEyY2VWXD+L4L/ejvINVESGvopUitpsXNR5b87HrTjAGD+4TN0S+aA2rW5xWkPLcszaP/8f2HHGk2z9CPKwq5DUReEiCdDSfu4vefwwwz0W+hrnAj8ztpC1/Uv3J+LaEIxzNJDf62TyEFPOKasm2IaON2smT+U48Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113059; c=relaxed/simple;
	bh=lYFYoiZfKGbsDCFt8rRgDQXDCYcESBLq+ipV1Uxz/qI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hUKcrT+k2vDQLrxmAYsCnfjfLUxC1umUWqsbTvNSq+WIuB6Bkxm/SxvVZC6S+MZKhbE7eIPwTcZD6ZkEdRX4AtGzOcLB8MODzCxB22S0IEk3ZMCL41vxXoq/n4a59a/SL1rPDp5Em2cfOP5EtIyYtU8IEtAP4oup6Sj4zJ2+7gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XtADL1tj; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XtADL1tj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqaB5bdxK3xetJn6y5elA1LkRnSP5SJlHH/t1xybes+3JOZ/U6fCGTy6HfS3aqD4lDvw0c/4DXz9lefrf4VOOe4cC0psrtU2kE0GRG5bV/KK2DF1d1TCYM0PEcUROChUDDXl8ZbcPC5SVgxW4/b9mvQVdjg4HgtT12nMa/aCoSTLMegMWp3S7UKcAUKlp7mARQZZvUckRhpAInmXV78TIkiBGLTbZd3pB7k81RtfRvpctameH/Jy+c1SUOr8DhCWtLeWPHlJVcNZl0QNP7OExjr2A7U7CSbqnG5wouH2zQB0Us1u9DtDsbHFt4rNGPGRs1N/3Ws3s93u1u7EGNFzig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAvVZPn05T9nhkNXsmFWTfh/8powU2ve19ZVfCSuY9k=;
 b=qgbbzvZgTI7OEleIk272XJPyWlarWQbh3DKImB2b4YWYW0riaOoqBXYcNnNvE54nq7CAX2YVW/0EA4lrFsDLBUeNXQGMLn3hwV6lUZ9p1QZtx3dUT2xsDu8nTEi+Crmo6amCe17QawWnHKmqRZUZ3EILNubJJTPf2q+5TtkAVkJrLMjT7iWWYk6XaYw6D19hDco/Jkz3uy4ZedZpdpIDivqB5qRmv5/Vn4YSEx5Qqn2Gjzoec2ZWsrzv1eEft1rhMI7UIFCgAog3So29xiqanddl5D/UDwlbsx9fmINCMPA5ouQmzB09m3Fgmo9sLIjCf36oRqkh9G3kDkz7yFDwKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAvVZPn05T9nhkNXsmFWTfh/8powU2ve19ZVfCSuY9k=;
 b=XtADL1tjyn8YJsq6dEMoqhZXRN0ZxHie8AB830Pd0hy7r7bjU1hz0gkN4YzUv3G4HAZK/MnqxXr0RSTBqTDdEjGgip4oh8lWqS5Z0FBH/exEg8lHLQkl8rTry3ZvdGxTLozoN3/o5xMuK4Qa3bKVAMuCZ5ATexLMR4Fp6cOvkPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 09:37:35 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 09:37:35 +0000
Date: Fri, 14 Nov 2025 10:38:04 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alejandro Lucero Palau <alucerop@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	alejandro.lucero-palau@amd.com
Subject: Re: [PATCH v4 01/14] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <aRb4fGKjjpJDwMTx@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-2-rrichter@amd.com>
 <20251111144541.0000714d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111144541.0000714d@huawei.com>
X-ClientProxiedBy: FR4P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: af7f0d55-ea97-4d0e-b42c-08de2361714d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QN3vXVb8T3WmsifpDH+PnJgD9ARADBLBvpX66miaNJHaNul8mZ5jpHIE89m9?=
 =?us-ascii?Q?mEdJxEE7b3jIJVTu0aEb+RmQ1pTncaFNjKgaM4qRhmWRUtwyLv47JLmgT1CJ?=
 =?us-ascii?Q?BX4h8a3pHpQASBrFlt+TFswO082CGkjQEpO55sBdY358olKKD6spPeuSLrQC?=
 =?us-ascii?Q?JrJZjOENrDFU9lvye8QTge0Ovg/Y/TCyv9bWJSo9tCJD9OPwbkz6nllSAPne?=
 =?us-ascii?Q?8dPaHAaxq48omb3l9Oxma4ezbXLKEJMaHFK9koK0Ay2sqmNrcpDAFq52bj49?=
 =?us-ascii?Q?O0FzbxZ6TWBlWYNi1r2yI8fPGsDyHEHQMjMEIFFx/7F/ba5/OiqmKq3l3FjL?=
 =?us-ascii?Q?YKS7c1MwQrDtbxdUwS4WNaoAOzC+NX6p7svR+bqf78Urfztesyc9EH9+bHgI?=
 =?us-ascii?Q?1A54t48hLdE+ck9EeQJkOtFQ6ScgXtVVeIgkR8ShtLHqHVhRf72bEOJ6p/Cc?=
 =?us-ascii?Q?YomMIruVXL1G03YhjEnPUlYOBV3zjdZ+GuaNGaqOpocnHFjwnR7Kf4ojCo81?=
 =?us-ascii?Q?lqxrtMnRsD9EADjj3z3uEnMBDXL6mHOCwVg/mMBA6OBmoTp4bGxsL1MUGmAP?=
 =?us-ascii?Q?4v/WfVnM4a/VUIWccSwhgqoK63Aw4NE+TYGfWu/HLbvj6kVUaKuqoDHwyg4o?=
 =?us-ascii?Q?QGgiCSeRsb+xRzURFiKEzJiY/EqLJvSs0MQFTHpD6XXPv0zyG+EAi+EzqtK8?=
 =?us-ascii?Q?ZJ90RwYAJbG2QVe8zZ4pd84dFO3BrDYi6We7TUY7lvXBAMOpcxRn9nA5bbym?=
 =?us-ascii?Q?gSznRCwSbPfc3VwmUl9wraFEhgiuWK0tkP2qQjrtzeamrBHmGmvz1EL2cyln?=
 =?us-ascii?Q?zQC1Ce6WUjT2Ap7JJSrOyzpL/LeON7/SbuC6jawKvgB5ZLQvemdo2nAme9ra?=
 =?us-ascii?Q?+1bvjJNKrWYcgd4EEqO2TzbisE96xasCpk5FCuEpCj92NO5vZosJLWA1edAN?=
 =?us-ascii?Q?MEQ/WR0HraUazcv6AATZq0twHEBBAlk2idcr0geNrAEUIMP3uJX+MlSukVsR?=
 =?us-ascii?Q?VPFu3RX6gWBhi/NimhkmaKe+18EvsGYbSS4yG5V1UrteE6Vu3rsgcEKpYaWN?=
 =?us-ascii?Q?o9EWnnCn03cKfoUog9VC/1R9KcDjyinOtilf2ob7kvUTVZNnUR+gUi2Eb91r?=
 =?us-ascii?Q?fyRsY1dViAesjCo2OL7Ln0aHxvBF7fi6/4+VuolgsovMeD7FiL73A7NSq3NG?=
 =?us-ascii?Q?XcFF/U720f+yTjPSQLpSA43VuIQyhEzaYFpMl+H1Gle9OOfgoHOBjQim/rpp?=
 =?us-ascii?Q?H2Gq3CMN2OzV+SIe+nmFVbhVDUAOUIj+Ovt+zakkNazRxMxxnrIVxgHdbUHz?=
 =?us-ascii?Q?UYrXeZbfW90bD/bG8TCCKhULzH2eQwn/39015OzQk+La13S9fRrSDwDf0EQ2?=
 =?us-ascii?Q?N2R+fGZwi3wmQ7g4VLHrK1c3joM7czc3aSQ+/O7LCFNe5rABgeORPHx53p2W?=
 =?us-ascii?Q?fYp9iga09kRflhJsbJqimusgO+BnGtYJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6W3iGrCd0Y0phH3YAAJpJ26WLbsG3VgJ+x0CKrusQtYk5dN4J8DDUhGGoo1y?=
 =?us-ascii?Q?D5PZk4Xwh75vlPGG0tff5paBMi2Ryv4WvwHZ4WdG+dhgZ9+I6PdA/bqIv1WG?=
 =?us-ascii?Q?cfhgr2mqJAlAXIKmXEwZ1s1FE8kPOyVdWxpNUuYfx9tJffSWuucOmfHHQX8g?=
 =?us-ascii?Q?H7+aQeZEOSJRhOEroNa2wKP56woRFXhC1wHIIotsReVmUjlkuUztOmwO1WRD?=
 =?us-ascii?Q?4wzLfVPc7xW2naZs4PbpM9RczResnFDAFiATSGryzkfpvqbUAezlD84hn3Pv?=
 =?us-ascii?Q?eZ3prHxoXE9nFVnKkk+CzTkRfM7cDjAc46rwLMtAq1Ai5jRi82TJGI6Sbeci?=
 =?us-ascii?Q?wSErKKzESTuVf7cW9ixAsI+Sb0+YeeVlr+KP5p0Fiuror03/diAWPLOkwvvV?=
 =?us-ascii?Q?ZgDDHoQODmRvzBHmSm6rPxHkpSr+EZsGdHwkZG9H7N7WU0PlWDXJikpuV/Qt?=
 =?us-ascii?Q?OATpKviLvG3cidxXT/KYdzpLyfaYDukNqDPxazFWf86qmFCdPYF22FPwj1C0?=
 =?us-ascii?Q?gXGunsl3hW3v3Ga6wV4tMmZrWk0NwVrvNx2EPzkcDlKqZtarNL/EDmtV/ZsS?=
 =?us-ascii?Q?afjtMHZcBpfT7TgxURli9tDOcfpnxYqNkDMMJHokK1ylxWXoUcPHnxhUt81/?=
 =?us-ascii?Q?HEC7zFtQ8WPplXRJQTQPvxTQKWGthANJiyDlb4NMy/wsCehW9pM+WR1auHc/?=
 =?us-ascii?Q?osKi33aVZPR1eGvaCniR/fq8MR2lHvuc1Pz8EWKLW4SMR6+zyWeZgZv7DDyH?=
 =?us-ascii?Q?gSMLppPWgyu/xApQiLumK1pm2Sa5DELoEZl39Fxsu3AxbWa4AXlD5cs9SPcv?=
 =?us-ascii?Q?oHvQ+akuam8jKKTNSvYXO96sQQRGe76lJfO/dhDrbBT0sPt2ZEGldEcOHyRI?=
 =?us-ascii?Q?FXBiXqUbZOfdenXWmYhnJpxriI4qV4mtDqxZbFsTWmx2vUe0TEt0wxbRZOlv?=
 =?us-ascii?Q?IexBiyRhV7PaoWZ8wU2moytlKIgfgKM5q3ts3OF642xUnp1/fwyJ+sTHrev3?=
 =?us-ascii?Q?/UHqzGwZT9TxjJJ/o2GqIZ5XfoYWsCtb9Ln863RbLPBBk6+7msoJ4GLEhuv8?=
 =?us-ascii?Q?Z+f+dPBy47u4H/kpsLfHKo8YOIEqN3mOQhRnd86gpMYzZcfxdrO0POiQ4Ggs?=
 =?us-ascii?Q?JrREo8uiLxpFe3tvZpu/YGZ8DI+kWmpvU2auPQSYz7+DIQ+hVo1FWJemlQyl?=
 =?us-ascii?Q?Wv9j35Ut/rgoS/3NnFPjAgLfFRp4pVz2a1ZxKZkeGQst2sCVYEcH9tnseyRM?=
 =?us-ascii?Q?wxwxhClXS2vXfJWA2luSEEUST6IB7XRPv3yesIv2l65mz8gA1ceekw/O6a5p?=
 =?us-ascii?Q?f7KhfxU1x6AY1E47DXTzMQWb8t1xWLYMJy7996d7M2npMTyi+9J6CMLaJdFp?=
 =?us-ascii?Q?PX0S1NJJ9oi/VTDBs53/HFdl6aQoKi2OZnrkCFNwuAM2dJ1AytXcRur+ACjE?=
 =?us-ascii?Q?ovWCEM8ZZiJkFECRTPbQ8uZRXvIv//NyfhJ/cW9uAT0l8PRmdUr2hUcoTiXf?=
 =?us-ascii?Q?t7GCVDzoGhVGz23bqrLYT2Rw6pNbeVp33iOLCaCAQYHDQLzAsb7tJUyVzHKB?=
 =?us-ascii?Q?aTzRefi3ESVBknz5PO3leEkOh37jsqf7kXQSHWLK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af7f0d55-ea97-4d0e-b42c-08de2361714d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 09:37:35.4566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUf9gPBpM7GR2hg0wN9mCcclnRfeRee+z8l07W17YcH7bEJ5mi8ZzBf4fNaA9XUavNee9apBAZ7lHUObYtavHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

On 11.11.25 14:45:41, Jonathan Cameron wrote:
> On Mon, 3 Nov 2025 19:47:42 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > A region is always bound to a root decoder. The region's associated
> > root decoder is often needed. Add it to struct cxl_region.
> > 
> > This simplifies the code by removing dynamic lookups and the root
> > decoder argument from the function argument list where possible.
> > 
> > Patch is a prerequisite to implement address translation which uses
> > struct cxl_region to store all relevant region and interleaving
> > parameters. It changes the argument list of __construct_region() in
> > preparation of adding a context argument. Additionally the arg list of
> > cxl_region_attach_position() is simplified and the use of
> > to_cxl_root_decoder() removed, which always reconstructs and checks
> > the pointer. The pointer never changes and is frequently used. Code
> > becomes more readable as this amphazises the binding between both
> > objects.
> > 
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> Just a note to say this will (maybe just context) clash with Alejandro's rework
> around construct_region_begin()
> 
> https://lore.kernel.org/all/20251110153657.2706192-19-alejandro.lucero-palau@amd.com/
> 
> Probably easy to resolve, but worth both of you being aware if you hadn't noticed
> already!

I have checked the conflicts and they look trivial. There are no
"functional" conflicts.

Thanks for pointing out.

-Robert
