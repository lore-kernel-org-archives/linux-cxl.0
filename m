Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9F63090C5;
	Tue, 27 Jan 2026 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511763; cv=fail; b=dpGwfIE5HNs42fDVEQkVVaiayYAQdBxuAL7h8OsBuuZXMZ2cmC55qz6eQ+Y8xIk5zJUGmPc3dYndn4rFUX2xJGwpg1FUKKx1Mp2BSIz5Ike8Rhys06n1pgrTIALr+LUDyQjuVW0ZgQ2MHWaIui7W7uHtAYGnUCf5AiTsMM/HCZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511763; c=relaxed/simple;
	bh=9QwpIYTuG+r84dxPFkyeKZYsdLKeZeiYf9+yiqsrq/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bZSeR6a1qz2Nn6KJvmnM2cmN3tKnaHr6co41m9UJ/ccYGuLbEIGc3Uw5t4jfNct6YaRPlugFmZSG3UNbZuoMu0qKSaYPpCDmhcKrqM5dx5oMdZZb8arwjCcRy6WtbafCw/HVNCTzFjMFAIWEvMrInsir100gwvc4Z6Ey0qlCWH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=efB7xAGM; arc=fail smtp.client-ip=52.101.52.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="efB7xAGM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+SJP60CeHlcHPAPQdmucyGR6TE0waAVpRmEbWEWC2oe2E75UocGCRB/fcZPrsrz0aL8mhh5LYnxXZOWM55bHf5ul3mQhqM8aXlrbp2pKsjhg643doFZPnYAqj46YHFyv4oQo2922e+WjFjiI0pJAYogK7AN586c3TRvKv5nYHX6BQ6Ifm7UgPEUPjensiJIf4QbTDiq/RFV+ELckewFoo9dFRoHcA1lK38ehM3YHjuntCuZ7YLBaeB+TFP7S9jP9OAeGrJGiAbiPGv3aikQI2JPHrrQqLKvzXskARy3zIihYLKBWpKHcFCeFZR4b366k8QJRHVm/q4McEtkhJVyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XvfgqcT/ZdEx2ab7iG8081hSV3u/pppDHFrAfHgzers=;
 b=N7QaH/MDetv0Z+7BPScRASmyFwNYgPd7UOaiZeClQORW2YuwY90Ndpx0m4skFvI1Sv5iTxIn3tjzhgO4DMdsi1N2MBu6mWXhVvcK7O+1VgcP5IqawNnHpRTyg++JXjwUlLrRHWsWKtzbvfqhJ9Cm3/nzrf5S0uCZWFNd1VWyiVy9d+yKV/8BXyUHSdLBlcXl5bWW1asFJdzXF20MwjCO9qpNUc/PfUH/U22x7o+m6A5jhuHFWUR7uKEqShph/2bTeizeW4ARACJslD2ZaJflkmqNdQDc544JhDPAr9QX4gxu7lZzCo5bI7Szx/qLTRoR9ilMpWnew7A9pUrIr4gGLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvfgqcT/ZdEx2ab7iG8081hSV3u/pppDHFrAfHgzers=;
 b=efB7xAGMoU0UOPsTgmMCA1IyI4AHanuVNFr0FmSxrcYMRJ1ZkgsBpAX+lmxA8ZkBssW4ZxCBUBox26+T8fhwszIkeFlwUXgxaBL73PQbBXrruTQh4wsfb5UTFOz2sMAxZXLT10d1r/OLAiOFW5a9SfsSZVnjQjEVKTfERPbWHwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB6191.namprd12.prod.outlook.com (2603:10b6:8:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 11:02:38 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 11:02:37 +0000
Date: Tue, 27 Jan 2026 12:02:31 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v10 00/13] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aXibR6DjiWSzsd6l@rric.localdomain>
References: <20260114164837.1076338-1-rrichter@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114164837.1076338-1-rrichter@amd.com>
X-ClientProxiedBy: FR4P281CA0047.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::14) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB6191:EE_
X-MS-Office365-Filtering-Correlation-Id: bbaa69b9-443c-4b55-4b7f-08de5d939501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5JIXrRPmmTtHoqCBV6VxI+Jkfxm1AxsSkE/E+zlcLzRSWiXK6CxXNmeG2+/K?=
 =?us-ascii?Q?vlforYnxgQDped9lBYWPs8O8eu7DvwTg64FVT+HCkbnNxvlPd6kOfLl9CMTo?=
 =?us-ascii?Q?HvXs2htpFVlg09g6OYlto1vWhyDsjlyXKOX0fD1nluBDmn61fRkvczrJYwUm?=
 =?us-ascii?Q?XAvNbJqjrEE33O6in3UszA3PwUL9g98m+A9mvCQ+p+3jDzdaSZDpWt/qbiZv?=
 =?us-ascii?Q?GcFTR/bUMVHPEwBtsaD4OurqOui+aVsEuLxsKPnB6yFOQFNWLvETnm/UjKE6?=
 =?us-ascii?Q?QQwG1fOsY3PhxXcV3YpNaah2aKMuZTyRCEflkAS8jO9RrkAjAkAiCCefNvLg?=
 =?us-ascii?Q?vBV2I73WgFqhXCIVKCghMR0i/oOugeQ77yM+LSYR34K8BnmONKaDn6MLa0Y1?=
 =?us-ascii?Q?BPj/KlhEXgG0CWbL7KnViptSRzEFjTV8OQ/6Ewz284Bw8ilBk/LtgvAcOVUn?=
 =?us-ascii?Q?3V7KNpyqHuHUBSz6zMVYluYZouqqYtUdCQvljajEYewUgIG7kl1OFnPti2qZ?=
 =?us-ascii?Q?WYirJKd309P6z0RbhjB3N7Ed/uTNURWiQ8lfvA8NfOWxOV4TYhwk7eyn0AUJ?=
 =?us-ascii?Q?zBe5jQGzUCCprBdblXa5jGzAf0k3KtnCflER7fLT9q/B9bEZWiDDFT15D2tC?=
 =?us-ascii?Q?LK40NdWwdcJ7PJz9sgN6r0YGUjFZMmTw8yUh5AbmVFwz4DoRFNjHFXG+qrXz?=
 =?us-ascii?Q?qxERQ0RoPTkr+41d+gmzSq5tJ00r93nW3YCQcca/WbFgW4Ns1AEZjnNhtiIL?=
 =?us-ascii?Q?M4TCc+PD5M5q3ob06QCk302FhRevovrY5vsQ9nMTJuDODiQfv4hrP+sDezS2?=
 =?us-ascii?Q?pGYgwwZsOP6vs2kiowSHCqRt3cOJT8kQtpBap5wINNA4alAB7AhoaK7ckIvM?=
 =?us-ascii?Q?mhZD3eHJAxD9O7oSxY/Kzn6fvHX8mTfGUeLqGqbGQKbTVnOtBXwcFUeHm+wL?=
 =?us-ascii?Q?9BRN8lde7AFqLepBybGGbH/5x9pB1iEtSZ3utgMXmYdL4ddARwNa4MrxcuHJ?=
 =?us-ascii?Q?Fw8ktPt0BUUDGPqwz5bZzkO4SB8CockbUA18Ne3H7CzGctNFVFClGrr3J7sw?=
 =?us-ascii?Q?rf64hHhkwc3VRxjMcmOXGw3NAowFXjIT8XPQel+dJ+0xN5VyRtD924ZzYEex?=
 =?us-ascii?Q?mD8vrDkkoFxLWtUJ3sqwWhKLN1EKwDkNmK3ZR4dEqIqSHYn6ii0oOziecc6M?=
 =?us-ascii?Q?P6/X23rKY40hr8DoaGlSS57CAEomls3iotrdCwOxDFP+q9KJGQJHDT1KkZT6?=
 =?us-ascii?Q?UamSWlCbAeABqrNXgBqcJSyz7vA+loNPdYIZ5r/TjY2mFH2oRopQYPz2oGr4?=
 =?us-ascii?Q?xp9yqyfXpEsICQevy+nv5wCUUpPOBnpgSXYWtdl+zeEGRFcvaHxkS+oVUbuW?=
 =?us-ascii?Q?iPVZ4yorefaqhZeYLvbOI51coOxgnObw2L8BSzPO4QAAFiToiOr8bRGM6dvY?=
 =?us-ascii?Q?ySBkkuhKNVdfctqXXYI7iY/Dg8ZaUojrWXHPN+rFOkqXXhryEPqrL00iWo8R?=
 =?us-ascii?Q?QK8H0LFGzx7N4x52ZAkUZkcbMfxGxFZuUyKDfVanhr0BN7wJ30ckiyTdBv6p?=
 =?us-ascii?Q?1atPZnJem6j0rakX/bE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rURXZj1GX1lvN24Mc9TS+dSsYD1TPMGNBv9OVLPAjMPvKuTUnQ1JugkQZ7px?=
 =?us-ascii?Q?yjIjFjUEQFJjo34adf/b38H6/03DwcoqO4SlO7gRyYPVNeLC3Pnc85ADgz1x?=
 =?us-ascii?Q?Q5g2bzJ1rlE2/XzKy8wX+xeEL2tluccondQ5iXfwe4R2SEShYQkdYl1ul7cd?=
 =?us-ascii?Q?WZ36q+noklBARpIeJkBuR/SS8uKTH2QoxyU62SLI4QA0c82PE7RCWMl9VI8O?=
 =?us-ascii?Q?FhLzeUOFAfJNm8lJjGC8LnDdNBkgQgsK8uYQtyHLer4Nti5AsUDdYEib+DuR?=
 =?us-ascii?Q?E4pkrUURbgmCWhdFFku+YYXhjNRLT2iokjXOwg5QkxurPs+RqXLd2IaCXopW?=
 =?us-ascii?Q?fQ1WgC4LkIGvyKd9QwpQ6DqlMKNQOeSESIuAjtn5B/N+oS/1yq1ExSbp8Ugg?=
 =?us-ascii?Q?ozhN8FLisKrJ7RWYsDIzyIaou/vYqELTat83njrM2dwpF4SVPNPjNvuHQc3P?=
 =?us-ascii?Q?N40BspaMOaGCJguq9prbZJtI/EVyz/jUYjNtAk1EMG/++DsN3puoUrhAyrIV?=
 =?us-ascii?Q?fR2RxhtUIp0kf/fp3+5/Kq5widhH7228lwt6ZS93CBY3+hYhZ+0QA7lWfCsU?=
 =?us-ascii?Q?xRubjSFbQWGiCc0lCnMraYQcEE7k0BOiVVcTe2mm9+bATesbVqqwQvdJGr5I?=
 =?us-ascii?Q?InrkQKxfI6WdnvLRnYi0sqhivvIbH7VWwqUdpe/t/88TRKoxRwZRbJAJlH8n?=
 =?us-ascii?Q?8gJ7z8segfmmhFcH5kzhE+gcDKGBthYmng48HEKHkljqHeNBuvQrJ8PGv3g8?=
 =?us-ascii?Q?pJIRT4LAm7VOR40lbp8UvX3FeOXPN+Mbjyxh44CORSUFsEpDNXSrwSN7zjh5?=
 =?us-ascii?Q?dFapwzbJu01Q7AnJ6rX1hyH9Bfz8qxdT6oTVxdcTEDi5pFIwZJzmL9Dcnevk?=
 =?us-ascii?Q?B3mm1hJdMRimZiImINf/vkjayb1/ywVt4WTDBHRrdGBkECZKmD93etE3R5ii?=
 =?us-ascii?Q?Aeud9IBOmrP80kON1t1L1r1zITvLamF3fpCRKj48vMrXV2uMpu4o2ANq9dRZ?=
 =?us-ascii?Q?01W87U6y1GaDcpIRYrtr3dv0HzN8KHzqbMH5GOKFJ2EU7GZjIImUJUhjdsD2?=
 =?us-ascii?Q?QFLcBB9PsAEuipNO17bYBtOfg0Qya2UQfd2rChImC8+EVplTgli2l/ic5/Ea?=
 =?us-ascii?Q?EvtSGv/DA/p2HUVAUSE2PjrAZ3pgJSbMPWkMvZy7uKAhfOurXgzsxjaQrSoZ?=
 =?us-ascii?Q?2zmVhbbwaro1H52dC0U3eik6Yv4lyFMYd7BsgjyqBrgvvhrjk2wBWMXYTe9Z?=
 =?us-ascii?Q?0tZMeiMo8U706cFQmAz+L4ttIpzgApgwLIzBSEI4FeyAZVatPPg0Akxh+zrO?=
 =?us-ascii?Q?rxLQ7wrSy97rELJO4TR0aljUixTcGCIyUKMyBZoUSloVZ7mf+/nKUq163R87?=
 =?us-ascii?Q?lSt6d7MpD5NEOdrZq9Cvwwy3+OSX2wMFVdMBM7+AUkE95EOJNQhzjXNN4Bpk?=
 =?us-ascii?Q?bmxpTgsnF0MxbIMK7n+t1lPlG/Hk7TVorSHQ2SLamdrYpEqvUImx3JV/a3o/?=
 =?us-ascii?Q?vMX/PC8RwLkag2nbluDJFJe55+InEg/RDOm/6aHf7M9Q+7J4HFw7rjimfZPc?=
 =?us-ascii?Q?XqssgfvEo8NzscwRweVy6zM7LgGNCrpufIW/e8P5BPL8u8B+2uG/TZStmkoP?=
 =?us-ascii?Q?89zjI8j0s4eJDvQAhf6GZMPld8yI0uLv/rGrjpHtCnQSN81Hsg8qrUCJJBz4?=
 =?us-ascii?Q?6wO0IxX/Zt3Mi0/Cl67DkAV0ipc4FZjKE9FjDP7FMtvJmcad?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaa69b9-443c-4b55-4b7f-08de5d939501
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 11:02:37.6994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3rvBMMyC6Xrx8ixrbMjzpzk/9++heWwQZTN4tv81foHt7fAXTUVrriCK3DgfOfJ/d20LwzyBWYyeiXlPZmESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6191

Dave,

On 14.01.26 17:48:16, Robert Richter wrote:
> This patch set adds support for address translation using ACPI PRM and
> enables this for AMD Zen5 platforms. The current approach bases on v4
> and is in response to earlier attempts to implement CXL address
> translation:
> 
>  * v1: [1] and the comments on it, esp. Dan's [2],
>  * v2: [3] and comments on [4], esp. Dave's [5],
>  * v3: [6] and comments on it, esp. Dave's [7],
>  * v4: [8].
> 
> In this version there are a view minor but no major changes. See the
> changelog for details. Thank you all for your reviews and testing.
> 
> Documentation of CXL Address Translation Support will be added to the
> Kernel's "Compute Express Link: Linux Conventions". This patch
> submission will be the base for a documentation patch that describes CXL
> Address Translation support accordingly.
> 
> The CXL driver currently does not implement address translation which
> assumes the host physical addresses (HPA) and system physical
> addresses (SPA) are equal.
> 
> Systems with different HPA and SPA addresses need address translation.
> If this is the case, the hardware addresses esp. used in the HDM
> decoder configurations are different to the system's or parent port
> address ranges. E.g. AMD Zen5 systems may be configured to use
> 'Normalized addresses'. Then, CXL endpoints have their own physical
> address base which is not the same as the SPA used by the CXL host
> bridge. Thus, addresses need to be translated from the endpoint's to
> its CXL host bridge's address range.
> 
> To enable address translation, the endpoint's HPA range must be
> translated to the CXL host bridge's address range. A callback is
> introduced to translate a decoder's HPA to the CXL host bridge's
> address range. The callback is then used to determine the region
> parameters which includes the SPA translated address range of the
> endpoint decoder and the interleaving configuration. This is stored in
> struct cxl_region which allows an endpoint decoder to determine that
> parameters based on its assigned region.
> 
> Note that only auto-discovery of decoders is supported. Thus, decoders
> are locked and cannot be configured manually.
> 
> Finally, Zen5 address translation is enabled using ACPI PRMT.
> 
> This series bases on v6.19-rc1.
> 
> V10:
>  * updated sob-chains,
>  * renamed flags to CXL_*_F_NORMALIZED_ADDRESSING (Dave),
>  * fixed spelling in 07/13 patch description (Alison),
>  * be more precise on poison support in 12/13 patch description (Alison),

are you fine with the series? I have also submitted the documentation
update with the changes Dan requested, see this one:

 [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement

I don't see any open items. Should I resend a v11 with all remaining
reviewed-by tags and the small update in the description of 13/13?
Please let me know.

Thanks,

-Robert
