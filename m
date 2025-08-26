Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C1D34DCC4;
	Tue, 26 Aug 2025 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216208; cv=fail; b=Rz7lt5BDwSyg43Z98ua7aD5K67E3LgUsfNOZQyZxjjey1V5yOlLg5B48k18Okfdkwc1WhqxqK6Fx/lWkt8xjBPz4Du9DDZxOkhJk2yC0TC5C1YvAFjicOBnz5pPYVoSR1tXUK68+gk7VSyI4g+yo67tz8mHXphvyZrN0ko+CXdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216208; c=relaxed/simple;
	bh=MTzz4hnEOQ6SfcnrDU1N4SXvWCzGneLVS9CMheQGcPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GXQUrKPAw18M+lgG1WLHpiHRAcpUMZHhTdBovl20Fbk7+5W6IsagWc1UfDU2SYQNHXtuIDs4wTGFT1pGtRUVpN5f1Sx9CrI5E8OzRTBsrM+ey5tSNBO3sm/9qQHh2rchBeSYbQA6YqnVQz8boiHF3KaNBLepguPbAAV3J+FKeYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wwTLV+Ls; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wwTLV+Ls"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8qAiRjjU6xB974hiMT4myUpbgCxy08C20NY0SkvaQw6FLwm9zpZALk7E/RwhJxStxi5aZnHLsJQvGGMRvULFGtLngiA5wB4I2YHdF7QHtQ4GUeUITHk5JW2rnniveZkGepdVZum0mjgvZlr+YaifTIn+jugFfzaKaoJliEhAYZzuyzAEAOsO8GVFSuGeMzsvDzWrHO8d6HZo2bOR0xxp6xkKjFmKsFWLoC5Rc6sxfaWWIv9nbyo9o81o8fY56mmv5WQ8NIRmri9/ECt2LNy8ZOj2bWbCwkYK4nL8wR78ks7jedtZdXF7UB5Nk4s9IQejbBqdAUNy1GUys2mEdwPrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TEtru6pxs28ch1wnUWHOTyPyNTfrOo8KgWkkeCvOSZE=;
 b=A8b0yIWTT6PsIDAMzzvPLD8rTgIaOF+CmjaYh4rkJd7Ox5Vpd2SCE3p3vt+PmEe0PiqrT00Vc1cIK+vqlPs670EY7Lx+vqv9WDeZ+cBN+Gc21kaDtPvuiEi9HhaSf19+5Zu4zpyB04wlIHsngB3vSkE7fgE/3JcybT+V2wq1gM0F0DSzSzCOWiFo3/cIJ0lWLk7JiHW4XP0swGa4T9AjH9/1rSTyLb2h1KDC59Ie1M9Il2mniwndJktd5ekq1z3PgMwPFfsVeqQOy91V67lk9sQHZ/IfIJHWraf0UdFVDwueaj8/mJQVIetrShrp19CywO6XxYaca1RSZQ/yNnmkWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEtru6pxs28ch1wnUWHOTyPyNTfrOo8KgWkkeCvOSZE=;
 b=wwTLV+Ls30XSjpPnRFeSezul3I0V7PIIleJ4dXDF3wGZqCqs+dCi/xnAVJPfSuCrOY1emtaQMHihrnOCG6L0xXvzXsVu8UV53GhI8Oyp4kXK2j3Oi51r7xf9isNTzpbjgHnm+CeMKbetD5RbLWLpxFqW3kcByyUfTu9G1NsZrzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 13:50:04 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9052.014; Tue, 26 Aug 2025
 13:50:04 +0000
Date: Tue, 26 Aug 2025 15:49:58 +0200
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts
 between CFMWS, LMH, Decoders
Message-ID: <aK27hvifBdqZK5-v@rric.localdomain>
References: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: c8746f8f-f8ab-49ed-4c1e-08dde4a7759a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGZMMXV1VStQRXBHUXpLWTZhVzRSK0RuY29aYTRtK1ZWQTZVaE8xcHpoZVlO?=
 =?utf-8?B?aW9HSWlvN0g1aFRZQ2Rodk9GbDhIRXQrSFRaZXZWMzdIS1pic2czR0llM0wx?=
 =?utf-8?B?eEtKR0VRYlc1RmNVRndjQlZURXM3YVpabHBmY1FzNHNVS0NLenJwV1V2N0Uw?=
 =?utf-8?B?eGU5TEZwTHpBYkJXMWFxbHhEWVpYeWV4dk5Ea1FPenhOUVJzVmwzZDd1UTM4?=
 =?utf-8?B?ZVF3dWRTYlkrZ0IvTUY4NmxXRnpvbU9GMk5xSGxTY2VianFENjlGekdRQlJH?=
 =?utf-8?B?TFI1amtwb25ROHJCT09ERnFURkJKTW1vV25VRURMdC9VUVVhelNSeG92R1Y4?=
 =?utf-8?B?RUxTbXdJajIwVXRrQmVKUEllalpHaHNZOUZDR0JiZ3NDaDlHbG04bXoyM2pF?=
 =?utf-8?B?cjlxQTJOZklPcXlsYjIvNU02bUxMOUluaFRzbW9TSSs5VUdWVTlXT0xUUHdQ?=
 =?utf-8?B?S2FMbnNxZ28vemtQT01sTUkzak5nUE5qeDNTcUtWSWJpWCtvaU1nK21JdXkv?=
 =?utf-8?B?R3RvYzFUQ05qMkM2djZzNmpTNlBEK0hHZ3k3bG42MjdKTDhnUktieXp1NmpH?=
 =?utf-8?B?enJERG9kNUMvV1ZMbURiKy9FNjEyNTd6elVSS2tyVThFYU96R25iZzVrYjBR?=
 =?utf-8?B?QjQyYmRjMGxuRG5Bcll3dmhEclZ2WDZhOHBvWmh5UEdqLzN4aDRLd1d4UDdF?=
 =?utf-8?B?ZVhtbS9tdHpzcytySVkyTm54akE0MWJNcnZzTjYzMm5JczRxSm1ZWjBwdEV1?=
 =?utf-8?B?ZTkrTDd3RnhaM0JnRWYzdDdYQnZLYkN2TXJ6bTdKR3hhQTYxQ0ljNW1YaUYr?=
 =?utf-8?B?Y0lDbFlURFI1R2lITU9ucDBCMUNNNlJRamxnRlNKaDVLNUxlbW9IVDdnYlor?=
 =?utf-8?B?VHQ2UDh6c2RLTzN4QkhxNjM1enFEYmsxM3dKd2ZiaEF0OEZER2ZobngwS0Zu?=
 =?utf-8?B?c21Ycm5PNlJ4TU5FUmc2Y2JZM2k0Qkwyb2xYU2ljTXlMWnRpblg5WVhFZ1Ir?=
 =?utf-8?B?M3VBQ1YwRzR6ampzUXZEQ2F0K21UUVJhdzJtZ1dObnN3UzFiUUNEKzY5enhs?=
 =?utf-8?B?enlIM0VkVHVQSVlFMXdkQ3N2T2NWWFVGcGVFL3VQSllhQ2d3QVEva1ZXS2R4?=
 =?utf-8?B?bEE4bU83aTFBUm40QUplcHFNejZOcDNIVzYrSGVEdGs1bkVyYmE4ZFZ5ejUz?=
 =?utf-8?B?TVRBRExoVC9neXhPK0YxeUNIaFVVWWdraDk3b053WHptYStUekhGNHZFMStK?=
 =?utf-8?B?cnNkR3dlSUxrQmVCYng4VFI4N3pFcmoyek85cVpIcEJBaGdMdk82Z1N3ZnJX?=
 =?utf-8?B?QkFoTmcwcXRCZWYxN1VKNHhmUUNSMWVxeXRLZHlXZkJkRXBUdzlsUndic3VX?=
 =?utf-8?B?TnNodTZxUXhoUGNxN2xDN1Vxc3hUT0Fxd3dZSUVQQjBKQnZqdzBxcXZEQ0ZY?=
 =?utf-8?B?RHIyb2wzME56SmFmajdKMTdyMTd0Z0RBS2tVenFrUGFkSFd0NzF5TDNaS3Zz?=
 =?utf-8?B?R0prQURqUlJuOU1DNjRVWmwxaFlEbnN2d0FRdE5wVFJYeUJqMHNvWkc4ZW0z?=
 =?utf-8?B?WThqSVhBeTczREhFMkkyb013YzdHblQ5VkU3ZG9SQlRlU0FaaFJPdHB1MXBn?=
 =?utf-8?B?UUhuTUo5NnpGTWViTVhwdGNraUt5dThlVitYWWUwSGN6REFBRjcvVGJlR2Np?=
 =?utf-8?B?cVVCakFKdUdqNFNLOGpYTHJlRHN2bmFzREYzbVF5RUFCWWh0OTJacXBZMTZw?=
 =?utf-8?B?Qm0vZ1ZsMTYwM2RjQzV4MG9YendBQ2R3NDNtbFF4RUl2d0hpV3k3M21iNVZT?=
 =?utf-8?Q?eaAw3jHQ+lyvNtsnfC/3CM1GdkEEkdIjDAgyY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1Rmcm1veUJoK2RaSlFCSXVaNzJQTTlVbDk5TURnbUExeG1WVENqUGRCZmNN?=
 =?utf-8?B?TnpjY3NrZGZDL1RKWGtYZG1KUlcvUlZvbzRDVUJETGFKUGNmREdFUWMwRFRi?=
 =?utf-8?B?WU5iMGd5UHNwa0ExOXUyUzQ5byttZWpLallRdjN6WUlCaXBVLzYwa1dIdU5W?=
 =?utf-8?B?N2ZpWUNqMmFweUFNTDh0cmZveXlOZ094dEtoaWF6TEZQY3FFRmxlMnBKVklU?=
 =?utf-8?B?bzZZNTRNSmFPcm9uUnB3MU9oRTFEeDZMbmkxZkgwbHZCZmkrSU13djJGMFRN?=
 =?utf-8?B?Y0RranJaZFVkUzFia2EzSVRMQWFtNzc3Tk9xaU9mRy9nUU92bnUvV2Q0a0Ey?=
 =?utf-8?B?RkVhOUxSR1B6RVd4VGE1dUgwTFQwVm9pcXJ1cnVpN3ZUY3cvYVRQUWFlN1k3?=
 =?utf-8?B?Ti9vTXdZRFoxTTJ6eDdjTDBPNW1jZ0FDa3BJQnNPcXZ5T0EvWnI4MlBLQVY5?=
 =?utf-8?B?cXh5aUZUTnFqOTdnc3dMNEQvbjNvQUhzREZPS2FjVzRWK1lJUllzWW1VcktZ?=
 =?utf-8?B?S1BzRVhhMWsvZjlYUndEL2thb2lLV1N1Vmp3ZldEdUhPVStxYWxxRzA5Mko0?=
 =?utf-8?B?YUkrdXp0NHBibmw3azFKMzRPQmVjWTNJaFROM0FaWnExd2h5WGJkSjliUVl2?=
 =?utf-8?B?NkJIL0orZCtaNm5RT0t5S3dTdHNwWENPa0hmTmN4NGZwSDBaaDMzeVJ0QWZn?=
 =?utf-8?B?N050Uk0rcmlmeTVzQkZRZnVrOUlqYnJ2L2g3SkY0S1FHdmsrUTg4WHdlQm81?=
 =?utf-8?B?b2hOZ3JtUGpidG5hNXphMFBTbnQ1NU96bGZoWjYxY1RkMUVUdi9tRStFOE1E?=
 =?utf-8?B?RHRzUnVVWEpJQVJwR2FmWkY0YWpqNFpqT2dTa0dlS2h0MFkxekNhQ3hZWXZi?=
 =?utf-8?B?M2d3SytqN0FGc1ltcFM2bFZ0Nk0yQXJ3dGVLOEhwUnVGTFg3OFVham9zNGl1?=
 =?utf-8?B?Y2s1biszeVMvTTdNY1ZZS0pjQzlKTzI4ZWVaZ1JLMlhEQ2tESjJ3U2hpR01a?=
 =?utf-8?B?RVV5U1ljTG1qY255blh4L1hEa3hrM3VMVlVXMHl4d3p3WlArSW1wWmUyOGht?=
 =?utf-8?B?N09NNTJaOFgxV0VZWVZpN2hhbm55SndBbkVuYWExYlU4UjhTZWM3ajhRd1ZP?=
 =?utf-8?B?eVRZakwyZk5vK1o5UWFWV0ZrZWJ4UGVFY2YrOWJsUEttNjJyL3hrUjZqOGJC?=
 =?utf-8?B?QUE0RFUvTVJlMzYxSmRHRCtXMXd1ZlNsemM5dFg4Z20veWxweXF4UEdxR1Y2?=
 =?utf-8?B?VTdoOERwK1k1eW5jSEhqVEI4djhLVkZoUC9xRHI3MWpwYXJaTzEzQnE1Y1ZF?=
 =?utf-8?B?UHZGeTJiUndHczBiL0ZZcFZTZXZROEdRb3g1N1AwQXN2WXFlaFFXWWt5TUsy?=
 =?utf-8?B?bDVxLzdBUDg2V0ZsTTh5bklaYUg5a1ZWVzNEWXphOFlkaUZyY3MwYzhjam9l?=
 =?utf-8?B?ckdxY3NTd0JBTkJ2VEFsaFFqYWVWR3QySEZ0SjVNZzFmZWsraXc4N0NmRkI2?=
 =?utf-8?B?dUJya2ZYWEdnREZZcUtLMFVNWVhqVXpvclNVVEZ5dDIxbm9mMS9CRHdpSmhR?=
 =?utf-8?B?TlViTXZoZFoyYmNvRUJ6dUE2c3psRDU4dWtxdEY3dnBCbFRHblhwTWpUN1FB?=
 =?utf-8?B?STJNODdGbjFPcHJwOWw0WmdyZmxNbWd1RWlEdEVHV0hTN0x0WEhoNnpGWFNy?=
 =?utf-8?B?aVp1anN1bUNxaDY4TUlsUmpOTEc3dXFudlpIYjRMV2k4RDBpQ1h2M0NXUDE3?=
 =?utf-8?B?M2dCK0R4dktNMFo3SXliZ25WZmhQUldlampjeXQxNGRwL2k3SUU4bGwvcnVS?=
 =?utf-8?B?ZEU1R1pyZC8wL1kyRlZrV2UwN0p0dFZUam8yMDRKRWxCSjNkdU4wMHQwY2R5?=
 =?utf-8?B?MS9IQ2poREpaZm5RZEd3a1V3cEM4dGljMS95NDVmNVhwaDczY1o3a29DMU9T?=
 =?utf-8?B?OHRXK1Z4a01QYnd0TE9wN0loSWl6VGpRYmhOV0lLcUJlSWo0MGlpOWIwUkpI?=
 =?utf-8?B?Wlg1amtyMzEvUGFCWk0raDhzRGdZbzBBL2dnNGFXcUJwanlWd3BtcVVBZEpX?=
 =?utf-8?B?MkxCeUNXSE5UTE1yK3dSUW56K3NIOVVCQTF2QU1GR3lJdXZhUksyYzlBd05j?=
 =?utf-8?Q?o1h2A+fRa/bktNL6llqD8uPL4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8746f8f-f8ab-49ed-4c1e-08dde4a7759a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:50:04.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7p/druQUS6eFbfxedNd4U8YD0mIyiQMzJEOVWHx5QfVUN9PC10FzAjtwB/RnPmN/Pk9T/p11CtDESgDcXDhdTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923

Hi Fabio,

questions inline.

On 20.08.25 17:06:39, Fabio M. De Francesco wrote:
> Add documentation on how to resolve conflicts between CXL Fixed Memory
> Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
> Decoders.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
> 
> v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
> 	  Switch and Endpoint Decoders match and attach Regions in
> 	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
> 	  Remove a wrong argument about large interleaves (Jonathan)
> 
> v2 -> v3: Rework a few phrases for better clarity.
> 	  Fix grammar and syntactic errors (Randy, Alok).
> 	  Fix semantic errors ("size does not comply", Alok).
> 	  Fix technical errors ("decoder's total memory?", Alok).
> 	  
> v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.
> 
>  Documentation/driver-api/cxl/conventions.rst | 111 +++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 
> diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
> index da347a81a237..714240ed2e04 100644
> --- a/Documentation/driver-api/cxl/conventions.rst
> +++ b/Documentation/driver-api/cxl/conventions.rst
> @@ -45,3 +45,114 @@ Detailed Description of the Change
>  ----------------------------------
>  
>  <Propose spec language that corrects the conflict.>
> +
> +
> +Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
> +============================================================================
> +
> +Document
> +--------
> +
> +CXL Revision 3.2, Version 1.0
> +
> +License
> +-------
> +
> +SPDX-License Identifier: CC-BY-4.0
> +
> +Creator/Contributors
> +--------------------
> +
> +Fabio M. De Francesco, Intel
> +Dan J. Williams, Intel
> +Mahesh Natu, Intel
> +
> +Summary of the Change
> +---------------------
> +
> +According to the current CXL Specifications (Revision 3.2, Version 1.0),
> +the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> +Physical Address (HPA) windows associated with each CXL Host Bridge. Each
> +window represents a contiguous HPA range that may be interleaved across
> +one or more targets, including CXL Host Bridges. Each window has a set of
> +restrictions that govern its usage. It is the OSPM’s responsibility to
> +utilize each window for the specified use.
> +
> +Table 9-22 states the Window Size field contains the total number of
> +consecutive bytes of HPA this window represents. This value must be a
> +multiple of the Number of Interleave Ways * 256 MB.
> +
> +Platform Firmware (BIOS) might reserve physical addresses below 4 GB,
> +such as the Low Memory Hole for PCIe MMIO. In such cases, the CFMWS Range
> +Size may not adhere to the NIW * 256 MB rule.
> +
> +On these systems, BIOS publishes CFMWS to communicate the active System
> +Physical Address (SPA) ranges that map to a subset of the Host Physical
> +Address (HPA) ranges. The SPA range trims out the hole, resulting in lost
> +capacity in the endpoint with no SPA to map to the CXL HPA range that
> +exceeds the matching CFMWS range.
> +
> +E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
> +starting at 2 GB:
> +
> +Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
> +  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256

Could you explain the zero-base limit and how this is special to LMH
or multiple of 3-way configs? What if the HPA range is non-cxl
already? E.g. my system shows this:

[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x0000000075b5ffff] usable
[    0.000000] BIOS-e820: [mem 0x0000000075b60000-0x0000000075baafff] ACPI NVS
...

> +  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256

The EP's HDM decoder's HPA ranges overlap now as both start at 0.
Isn't that a spec violation: "Decoder m must cover an HPA range that
is below decoder m+1."?

For the second decoder, shouln't the upper limit be cut at 378 GB
(multiple of 3, or 372, multiple of 12)? But since the CFMWS Base is
non-zero that range is not detected to cut it?

> +
> +HDM decoder base and HDM decoder size represent all the 12 Endpoint
> +Decoders of a 12 way region and all the intermediate Switch Decoders.
> +They are configured by the BIOS according to the NIW * 256MB rule,
> +resulting in a HPA range size of 3GB.
> +
> +The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA
> +range base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0]
> +size is smaller (2GB) than that of the Switch and Endpoint Decoders that
> +make the hierarchy (3GB).
> +
> +On that platform, only the first 2GB will be potentially usable but,
> +because of the current specs, Linux fails to make them available to the
> +users. The driver expects that Root Decoder HPA size, which is equal to
> +the CFMWS from which it is configured, to be greater or equal to the
> +matching Switch and Endpoint HDM Decoders.
> +
> +The CXL driver fails to construct Regions and to attach Endpoint and
> +intermediate Switch Decoders to those Regions after their construction.
> +
> +In order to succeed with Region construction and Decoders attachment,
> +Linux must construct Regions with Root Decoders size, and then attach to
> +them all the intermediate Switch and Endpoint Decoders that are part of the
> +hierarchy, even though the Decoders HPA range sizes may be larger than
> +those Regions whose sizes are trimmed by Low Memory Holes.
> +
> +Benefits of the Change
> +----------------------
> +
> +Without this change, the OSPM wouldn't match Intermediate and Endpoint
> +Decoders with Root Decoders configured with CFMWS HPA sizes that don't
> +align with the NIW * 256MB constraint, leading to lost memdev capacity.
> +This change allows the OSPM to construct Regions and attach Intermediate
> +Switch and Endpoint Decoders to them, so that the addressable part of the
> +memory devices total capacity is not lost.
> +
> +References
> +----------
> +
> +Compute Express Link Specification Revision 3.2, Version 1.0
> +<https://www.computeexpresslink.org/>
> +
> +Detailed Description of the Change
> +----------------------------------
> +
> +The description of the Window Size field in table 9-22 needs to account
> +for platforms with Low Memory Holes, where SPA ranges might be subsets of
> +the endpoints' HPA. Therefore, it has to be changed to the following:
> +
> +"The total number of consecutive bytes of HPA this window represents.
> +This value shall be a multiple of NIW * 256 MB. On platforms that reserve
> +physical addresses below 4 GB, such as the Low Memory Hole for PCIe MMIO
> +on x86 or a requirement for greater than 8-way interleave CXL Regions
> +starting at address 0, an instance of CFMWS whose Base HPA is 0 might have
> +a window size that doesn't align with the NIW * 256 MB constraint. Note
> +that the matching intermediate Switch and Endpoint Decoders' HPA range
> +sizes must still align to the above-mentioned rule, but the memory capacity
> +that exceeds the CFMWS window size will not be accessible."

Have you considered to just allow smaller CFMWS ranges that just cut
the boundaries accordingly? That is, just search for a CFMWS range
within the EP's HPA ranges (or even multiple CFMWS ranges) and only
enable that HPA range? That would be more general and removes some
limitations, such as zero-base and below 4 GB only.

Thanks,

-Robert

> -- 
> 2.50.1
> 
