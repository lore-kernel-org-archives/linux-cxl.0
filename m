Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61922DFA40
	for <linux-cxl@vger.kernel.org>; Thu, 21 Aug 2025 11:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777447; cv=fail; b=YGEVAVaxOCYc4JoPS0Hzssc3Xxk6T+S4KewfLDrpPOD4hnY2yKDRPXcm0C48WNlwmDN/tCpZFG/xeL6Xe6w49EbfqYjzmcV/yeWaNGw+gKQSsY6M4vteqnTyO/P4pavdL8dGkJoSSC1Rt5g6E5AIfcx4r7xpPGDIwsNQ0V6ss0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777447; c=relaxed/simple;
	bh=42EP2jQdj+NQJ4+Zano9Tq2xgppDs9haOG8QdkcWdUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FbyXS8VVyUJaSyQoS2x8NYmxCXW6ps0VBt2NmDorKRtd3xa2MiZRO+BCGWq9wpdgdUvmNknQKzkzTQyZDGCBJex6DwKKadztskF2FnreOtqe0PYIpSmNVwnA88pw+PBYei0MCs8LxKgqEYLj5dk2iqGDxRrGnP0ZAHs9M9URFiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QSnhxced; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QSnhxced"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWnPcBMm3dXTURnDjyTCuj1V77zxz69a69pMJKf4MUiFcZA2b8B01lz56YqnHkTGn9GTUvwUju0oNwo3PoMmRv6H/XaJ+ACprDM2SGWMK+ZR5rZg8yJ6dLmQ7e89h9BVSzmGwqQtdkEPZJrFYEyVFS7C9aavHaekbQdpDcLuKQcLAJ/CYTfGcdVIAFFliD8fAY8F4uebA0bNabFQNi/PtRzEL2yP0tfC1qtFTfJwIBdgZVgAz9zDJsz73jKYpg23xB1nGNggjrwcZNjo8xj0sJOHvexr9Ag0ZxqVos6YxTfK/UHmsR+yw8wQ9ABjotZysVnKiEAZo2zYy4rWotkNMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9e3RlSCPmS/kFOe8nekfouNFBkoTyzoz61M4cAPSnl0=;
 b=Nh5oktEYAOEkp12b/8mlo6CD5b3gCWLc2o/dWaDvKfluIK0yw1e3g8S37dDyAhIHP8hFWbq2qM++fWbiQOZEK2eWTuMfwHO1wb+lLkb6WZxGxAyMxM6RbQPQjczVXdgvDSB+7FvLSX67yj8A1ZmwGsCMK8bpFyvTJfJVVUWQ4Rk6PQ+xVOmbeQsbZN1wpSQHZIr9e63YBWcWeNVhAFHPD1aGfQoZlmyyksmJyj+uDetV2ttccQn082ofXC70B0g/d2LVQaE/Q8ohMaCtMrjvZE6yYVgP2uRADDVN/5FDtXjcDyxf2RHBadNbZpkXuHV8W8xBcGXV5xSsgtFVv3OYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9e3RlSCPmS/kFOe8nekfouNFBkoTyzoz61M4cAPSnl0=;
 b=QSnhxcedx7p9wTXLXT60pO4n1sK8llVMuagHtYNZbBPgKQpsVTsZbNwotK9v+xXur4NOBRZYkTS8Qs02LCSivU4i/zuZjFMPMkAejSVhakzeKt0dKHloCqY5gyu5WupHccN35RzqMtO2oEonww003bUy6C3lfL/tpfZrMEF+9os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL1PR12MB5875.namprd12.prod.outlook.com (2603:10b6:208:397::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.25; Thu, 21 Aug
 2025 11:57:22 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9009.017; Thu, 21 Aug 2025
 11:57:22 +0000
Date: Thu, 21 Aug 2025 13:57:16 +0200
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: Re: [PATCH v8 04/11] cxl: Move port register setup to first dport
 appear
Message-ID: <aKcJnEBYk1AZf5ha@rric.localdomain>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
 <20250814222151.3520500-5-dave.jiang@intel.com>
 <20250815135735.0000685d@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815135735.0000685d@huawei.com>
X-ClientProxiedBy: FR4P281CA0307.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL1PR12MB5875:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d332098-f5a3-4753-72b2-08dde0a9e354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d607GU1mE2aFZXHeFoQzRNX5t8wN6xg4PbyfIp59/vCvxdDAsxKonmokhpxH?=
 =?us-ascii?Q?OAz0oQCZGwZNF13C+EiIIfcHlj5p3ymAYZsMgHvnhmirlYZwGJAYOw7Ojz3u?=
 =?us-ascii?Q?FnTq9zbNHXAB8dRSL+AC6attk3vSoIo9t2w3HWPFJTwzr2vFRsTpH9R0+sC/?=
 =?us-ascii?Q?+xliV8gR+JD3ELnUB1Lw3tT8p26fdhsU5E0s8hLjvmf/SHQpSSdZ7fCGzFU4?=
 =?us-ascii?Q?ic2drFL0rjsODETtIqp6uy0kCJTe+5vKF/PmtA38El+Ijdk7ptmb/njTqsp9?=
 =?us-ascii?Q?EHcHpCFReCZOKeCT+woXAVXtpNwsJ/YnMXoWHvqQpWWeCbTTxagUYI4LzT9G?=
 =?us-ascii?Q?1aj1zIagsaN5b3qWxs5lxt5LPC+s92Dsv6lWrA4/ZmWpHUjZn9y/tUz1x3xT?=
 =?us-ascii?Q?ezMGQoQluXGP5o33fGi1z8bLEkuUcjzP32JTaQy4sUM/0+6SoiqfghN3W8qK?=
 =?us-ascii?Q?iOk+E3nSXH5tgkiRJxvNNmckmwiLNdTJod5Qruexgh3BJcEF5ROaW/uFw5TI?=
 =?us-ascii?Q?AB547F2rauMIpOQdeXgKXUzPpjW2EEOjGi1XAer3ttvav1ZbmRhufufBoIk+?=
 =?us-ascii?Q?xxI2u0/VIrZY+eUy4VYHFeBUowEj2umEUnWP0thcwkPdevMrp+ikTQaU4Nfa?=
 =?us-ascii?Q?LVeZdA2/FzGsfZuvM1RQHaxUdJFq0NrtdxlE/3kmYdU8ghvytLqjqnHvqqWV?=
 =?us-ascii?Q?VF25c/SUDKKbapvLho6Vi1+z9/hnXidqOLXmOQcxtn69YY80UiGp2VGXlcck?=
 =?us-ascii?Q?XR09FoAPevMEUYyhdC6smhE4VFyIDgWqH3ov3wsNAQyzukCgUKJUzzjpztcU?=
 =?us-ascii?Q?Mpu2ITQhfGkpatrl/b2RCUnJMFcnldAzd63kce74WDZbu8lzr0NppuQ3Uca2?=
 =?us-ascii?Q?UYhH4KTRBcxahCwL2ttDGK40YQ7enh3wwNz2e7KGph9/iJP3aTBlhs6KCvDa?=
 =?us-ascii?Q?2uqiBkLQ8ccdib2//eveuICaDDsZtmCpU4xUd+keuB1uGKf/fL52EnUfcKPS?=
 =?us-ascii?Q?mjyVSfW0N/3qH/iK0tZ6Rlix7a4G/h7wgNI81A13On+og4qKlSiOMX5abUqv?=
 =?us-ascii?Q?g9OKhT2tPFkP89nUHXQDMzxjG8Mz6p6I7Wp09olOa+tyGbknWMCIcZ36Qzhw?=
 =?us-ascii?Q?K6hj2OCNwwNGYKsnR3RyBsRfWlwVQLj8zTk+ChyyyItehpLaHlAeiDtpIMyK?=
 =?us-ascii?Q?RRTyq+Glqxj9fWIaSobQ8WQvA1eZjdHtqGkiLJofv9DZqIEkzAvdw3VbZLws?=
 =?us-ascii?Q?sAlZb5DRH0kcICf6IS/7swhO5CN35akURz9hgWE/W4CGC0LH0pDbvpsbIC/1?=
 =?us-ascii?Q?RGRHSnWH7SBd2UrACNS4Ye+MXgWxGkvxS2pv5srvqW6ClrS7b1ILVIbp9n0y?=
 =?us-ascii?Q?/qPhdPnUxCPO2I74otZRAMU5c0lhuLQVF5SYk9B7RXjx7DiGug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XZxa372dWD6saVSa1nK/nXKTM/2Za4EGKDHBHbkfp3ZM92dmpAJLvKbp6NA?=
 =?us-ascii?Q?GvPgo/w5WmOwFVQMQIHKGvQJknp8UzKhayfNOJF3vwMlXjphwx85jfdHv3FJ?=
 =?us-ascii?Q?H/nOri9CNM8pdM8ONpfgX664ynBXPsJx12nSGbabeY9mMqXNl6UMX3zSoNv9?=
 =?us-ascii?Q?SEt37XWSDtyQH/dDGtBvyWtlQECpbi54zewN6adDvHj+Toh6SjapYEcnlsVd?=
 =?us-ascii?Q?zXm0TuvNcikkl18byPI/QNZHeX3Uim9RGMMJSFNcfmQJ8ndErTZtREz7WE+z?=
 =?us-ascii?Q?ZsKDfiGEEff4F8ec1PWbfwgiq5Spt4xmbaj3dvbPlUheFEVCwnKoJy3U3/NZ?=
 =?us-ascii?Q?4ab9/XznO/2bI9E/xnCZguRZLk6IQsmCnce34UuMaxsp3HM3lkqubm0Z4ajn?=
 =?us-ascii?Q?ah/dSjtyRTlLlA7syen7cMVmhJEJqpTDcctRc5/buZbn5kDmVCGnswi01h7I?=
 =?us-ascii?Q?jbQwSNyIYnXOMz+AEeS6PzLQkhbKKrfiM8B5YlUHgr7LpqHD1m4Gx+X9cAla?=
 =?us-ascii?Q?f1IjnbC7zgOAh2YBOiZvq3UEWyCstI1YjVbrcOHXmEfSc8qdbAOlVKXgdVRL?=
 =?us-ascii?Q?RcX2Gp7ctcFmV/idJix+Xvfb+p+BkBetVNkiqKzFafc6vTXQP5hzjNKaNSik?=
 =?us-ascii?Q?ONeq728RIRpaR+3PGc6F3lj8bvZEQ1pqAh7FonpkhgqYNCF2YhQxyVm7Tk5R?=
 =?us-ascii?Q?bIl04CTZ0q5zxJ/RgEbpj+rzNgXYYuwltL3rc28mtqktW5SD0vno6KQvGY5T?=
 =?us-ascii?Q?Gw9t9uTJZP3FTkHEWy71Y2I+SV2wDcGR4gXHC4DobeFYdAIoOlP0okA2GLDH?=
 =?us-ascii?Q?qHcl3Ybk9f6rqKJLEpdl7m+DCI8oLjSwFKny4PIQdaFh0npiIXGFTf2BLQVZ?=
 =?us-ascii?Q?8gRfO98vZamFia4YU5R1EbicdZavgj20Ck212XANk4/HNWxPcirmYbjz5VKl?=
 =?us-ascii?Q?4MCXYoIKOnF08IXBVSzpFOkhxUA01nEtSS4+eN3ZvEbb5glBaepmsfKJQIbP?=
 =?us-ascii?Q?UkkjdAWfyEdy4i5pBH0+WIomob9b90+nlNCO6f+aBzCemhL9JWwaQwpfAcAT?=
 =?us-ascii?Q?lxfEhxqn/zaHPh2wr85bJDrydeyvFQcae5nWK86DiZS9et+y4n18tQ8xWjKO?=
 =?us-ascii?Q?i9khrZFy/Qj9raOgVwN+tk7cuWboJq8593kN6XA9gaQfQLNLbHwiXaUWb0wS?=
 =?us-ascii?Q?HvqIilsa5ivVY8QM79oiA9IyPYSfc72jZT9+AsfP0Jh9ia7QZPe1m7HC15IC?=
 =?us-ascii?Q?n6P4aF6v7wtHhS3X1wt1ZQ0nVOdPXEAtQbIO3LEQiSsX4fl8YNc+q3uy7Tcq?=
 =?us-ascii?Q?SYtdNthFNvsewiNdWjTkaPmP53Z7ZEIFih1IP35h+Bkdw/1P+0Xi9kwZBzJs?=
 =?us-ascii?Q?AtMLq+2pzK+it/sy2f8QttONmaf7AyzIscCb7t8srQZwx34/HQ4jEEF/xjQM?=
 =?us-ascii?Q?PD2G+GMPUEpByoNWXuRg1wrJEBfcoo0nD1ocEs070v8CG/qjbmOFQex5b+am?=
 =?us-ascii?Q?n5/OCmephAstYPFON09Dy+fOf8IBk6AUzUepok6kpzCEfDglOTzvv3ICw/rb?=
 =?us-ascii?Q?p/3O8BShNZ1Xaftkh09BR7la43yEnkON0TpxVQ28?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d332098-f5a3-4753-72b2-08dde0a9e354
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:57:22.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWpycFPM4HuAEfXe1lwB5KhUtYVRvJPEOLIUr6pYBScEFOBKfwyXSsrnOMVxaYyLFfZh3WShEP29FMruMQzUMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5875

On 15.08.25 13:57:35, Jonathan Cameron wrote:

> I'm a little nervous about what happens when we hot unplug EPs
> on these systems and any left over address mappings for port to which
> they are connected.  But from previous discussions I think the argument
> was that they were benign if they do happen.

Yeah, unplug is tricky, we probably don't get the same state as
before. Let's see how tolerant the driver is.

-Robert
