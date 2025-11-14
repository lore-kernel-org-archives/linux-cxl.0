Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013071.outbound.protection.outlook.com [40.93.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFD0226CFE;
	Fri, 14 Nov 2025 07:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105673; cv=fail; b=O8DxaSQwNXyREtChXtlOP0s24+jf4Y9yMsOQCXLRRCnJzWczsafChrgmGuyFeLjijn8FO+XepekSHR585YHoPqZXiVeeP3abKi92ofzgXPqP0oCDSWYt/GmeaJMn2Pz3Xz+EDNuyRios2tPKvSXs1x3/4yVa3kQ0DSYOLOLyFRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105673; c=relaxed/simple;
	bh=dJJgWwqIExMoVqkHiguVhgfSPx4hS0pC+ligdYUarc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j5ggDUx6ak/PnVmGU/zgserrqjKlwm7ihd6AU9EEjwzjWXyFb/G1J5R76LdxVznLdlLWae/90NGu0zc12c2RAl/fJrqslR8dTSQGsfRXxYTWKH9SJgrp7FpbEiTNEVY8rYrxSORP04Kn7OLu+mxIvVtKTiqqIUdUsqL9/pRdm5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mpMKa3IC; arc=fail smtp.client-ip=40.93.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mpMKa3IC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WrSlqGfQ8yeIAU9YK3PRbmlkxm0Quu9JEg70RdookoXUwQMO3G85jdJo0JkyORIyNZZ9Mspmt0PccnaEtYYgC84zl0Y4jYkfr3m2Da3RfHInbfFqBo0LH26Ag1KlijWyIiuLmLwGDRq6F5eHq9ZdJMCZWz7wJg2e5vfI7P+1OUlg7/U0klVExDJO9Yi34BWp535cly/Ao2ITGasaSNjBWcmvpwmFU0Wb+niDBP2fnO3k0Qkj9DvHMh5lglrR1FDC/KCI+oEEtVepd6bMLVrMPiTI2iXaa2FmiOQqU16+Qwpi98oubPgp5a38IH0BNavyVB1orqwc8/e13h9iQb97OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDVYz0+OsPUycO8VaDqUIsGmyucFzDZz4wI7adVL8KU=;
 b=Uj7KvBHPwBy7vFUuqZEkP1xy4rZRIn8l8vrpDPGkmXl/nMbQh+GjfrKRS45TmgMZ6SLmIudEauUWwKt67CgcEVo8MnkdztewPoCY05SDRmL7AfSMXrXmNPH2s1KUJDkhuH31YBZDAoBcTUEipzHwWbKGDBdY9Jsa13nUI1Goa4hrwAM6ddrEL2Yg+qipWA/7pNtwOTY83Ocv6tBxkf4Dbqj3d2idCzT7oDOzeGCJqeY41WeVBn7F3U117p+F2PKDn8iKgwB95JVbeTfs7po8xhkzgHhpyhxOZoTOe5cZ0OWMhOjg3hPhRnuXJqd31CsygnpQJHF3w70G3UeueyU9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDVYz0+OsPUycO8VaDqUIsGmyucFzDZz4wI7adVL8KU=;
 b=mpMKa3ICvTiWGQ35q9DSHLjXRnlQ19VK9WJIyiiXvQRd8YxT5luFsxIXhJaDYL0EkGENy1SLYMT2Gxw5CdyCbk8Cx5y5/ywHZnaTOnWmGJiWK5V7UzDP7l3iPc0RY36L2KszbdvvPa1mp15j0ZlA38SRZL5lSKcq9DpgvMzI07o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB7223.namprd12.prod.outlook.com (2603:10b6:806:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Fri, 14 Nov
 2025 07:34:28 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 07:34:28 +0000
Date: Fri, 14 Nov 2025 08:34:56 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
Message-ID: <aRbboCjBhCujhh67@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-12-rrichter@amd.com>
 <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
 <aRMx-YYhaouP4LvR@rric.localdomain>
 <6f1eaf10-071c-41ad-bda3-62eb6b1119e9@intel.com>
 <aRY6EaTALW4SvkaW@rric.localdomain>
 <7eea091e-f241-4305-a233-ba56a4ed5df3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eea091e-f241-4305-a233-ba56a4ed5df3@intel.com>
X-ClientProxiedBy: FR4P281CA0357.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cba555b-75ca-46c9-a83f-08de23503e25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dat/dqVNuSNRrN+9tJazYsmGjLlMuVjdddVwvXXjqog6m3LXvD5Qi5O03PUE?=
 =?us-ascii?Q?/ktSbvaXdNvdYnvIgbcw6XqS46lZ22PE0vLO0XY9l2heFNk4vgj8gchO7BBl?=
 =?us-ascii?Q?XD8xr+LVhlwjX8X+L1J6MI1nPa7FfgXumDc9bhLESJA/Q7U5GJcypQI9T61+?=
 =?us-ascii?Q?4o9d6UcUR0IYT5q9EnPbEuGgHIAF3Y32Rbb9F0nm4BMyhfCgLcmZjfCxJ+Td?=
 =?us-ascii?Q?inkGR8YlDRvnjqA6u7Z7INHIaQ6jjXcr3i8oYnlvy6mTaZN69E/DehWpr1lm?=
 =?us-ascii?Q?cWH/PVkLoSYuSKvDfVJ87QJ+8M/cTaOrKzFSxVKQGSsDEp5Glt05dhfgp2p0?=
 =?us-ascii?Q?1tzDA9VxhTmW2cbgz3lhJhEArTyOHefSSTLNt41YCIcyUiddqNRCdnpr5AZ1?=
 =?us-ascii?Q?5JeNlPvTA8ga6VJ3JsdpjB+h+VMw82M5LRTKjAk6TIvsmyvabks1ZNpy2Dls?=
 =?us-ascii?Q?d2md71qnvDU8yMHnPM2rbloxKvf+bc9w9kn8fmKPGYRwb3XxC2IO/NMIEABO?=
 =?us-ascii?Q?uhcyKovRpoQO1Vbqee/IGrvSlbB+r7E3lgpnkeUZTauKOzOgC9YWSpPQkWc6?=
 =?us-ascii?Q?QCggEWwwN0/1RyaiZkJnZHSbmGOgij9hLB0NWPitQ3L/bVDoqG/ODuCTsbyR?=
 =?us-ascii?Q?/CQn1fO7co6XmDRIeXma01Ee7jZN1HJkV4xJlJhgChr4Bc/Smkz6Cdt3u5Ns?=
 =?us-ascii?Q?14SOQEVYz9b6kMu/IARfcadnhFD6F1KNjKPmL4gu18HAYuPTY1W8W1IEVkNw?=
 =?us-ascii?Q?nnLoNeN4cgmIFktsE8CHBO7uUR9vDoo7tjri/N1LZ6rYFlyngTX8pzeAluQn?=
 =?us-ascii?Q?301h3KURYkEATurrS5Idk2nykC26JBGMFM2OPLklepkcjhnDUCf3E+F1nQ9f?=
 =?us-ascii?Q?0ORNGApMkGNdHInKpHOR/jDLXw/q1jghjRf1J3qQbafY7GWYw8O0mVBBzLO0?=
 =?us-ascii?Q?PdlcX7FNAoF4nr+kNV1+jqbwiEfkCQ5lyr6mIRG9h45xEofGHcJGeIrYb06a?=
 =?us-ascii?Q?7X3oNtDWkWKlPajgc/g87owytWjAviB9dGya13ULeTpx771sQQEB0ZRVriL0?=
 =?us-ascii?Q?xpq7P6OlGwdnz99+exs7oCBmCFL2kaoHDEQcUKR0L+Ora2EF+Fbf+cNaa9pX?=
 =?us-ascii?Q?AWRD41psUsphERZq1ICr39Xi8o/gBjTJNhf9Fl86/GIAzL2RX2xjIr82jWn6?=
 =?us-ascii?Q?Ii/qcvMmoBrJPrI7n5JOSt2Dyp/jPfWFyg+5Y/cyK4WfSTDrjP7zI9PI4N6K?=
 =?us-ascii?Q?64oGqFJV09K8eEzQ1UoTDAmwLA39U84AonQaiWzfFRlbCjZV+IxX+aeiqpEV?=
 =?us-ascii?Q?u/oIE4yXMsZ5yfueJhaKLqnaTgf22ct9/BjrHyMa9Ug+g8PrgIwZAMOqEHYC?=
 =?us-ascii?Q?WUIbk6pLbRFJottqrzCj20hj3XMjXRzbTMmdpOnIECiH9ZrGpz2MFAqCr5w9?=
 =?us-ascii?Q?As4oST1xWAVYFAyWhFR4JeVoWW+4k2XV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZbQxb0n/IS+LG76sp/jiOCH1g6KZj5J9817XqEbYAbRL+iDGM+O3KOb6a05d?=
 =?us-ascii?Q?2cBFpypVYBUgbE3hf0hP65kW0oOURzrLmps2Mf82VQeOFGWzHG9/7ZKwtEfZ?=
 =?us-ascii?Q?BFF5UlqrHuS6M8Ay2VDoem4vo3T525LP33CaiKr8C9V3C82+SV6wt7EtJdBt?=
 =?us-ascii?Q?yzk5h1JGOrlFO5iTVfJknwLrjUveGetVsPSruKf80inj7LsbU4yHfdsayI3q?=
 =?us-ascii?Q?kClFrES/VY3KlGkxjBXNTMHvR6K1CFHNMAQCDaWSOVX/8UKzJO5k4TqtFq+J?=
 =?us-ascii?Q?SqwyiEqMd3umlpz+HXgC4CRZkUeI3OVHgps1U0y7FpeQRML+TBZZ+44s1K9u?=
 =?us-ascii?Q?ZbbmPAYYSDcxxD6+fWXwqYx3KJh6h8nlbOBXpvj2PvnCZMyvb1mEThOcLf2x?=
 =?us-ascii?Q?l+jhltAd216ZlPkBLsVTk0puKneiXBQYoWqdF1T5AZnZpXqBlRUjxfgsOt75?=
 =?us-ascii?Q?61MV2b8reqgal7hRPtHjky9YWb7/yvWwkGlijRN+jFm7YiFtH0RT1dBDsp7j?=
 =?us-ascii?Q?cJkJIhztuNtySIZI80b1CNsTD6GiQk2W3nGxw9D6ZOrBj+sHgrC+NVxIM//L?=
 =?us-ascii?Q?w0ZMd5NXgSVZf4cAXgRMzeMA243YZtBY9Sou+W5vFD0dC70UfofEuShSVfFM?=
 =?us-ascii?Q?WJadYFwYDSaQqO4FJ2w5mDWgx8mG4ipLX2eegsu+7mVUGjE/04u1Z6lc1DJp?=
 =?us-ascii?Q?GzANZYZ7brk3hz+HqJyzjIvPffbLoX5ERXKEY8/yDaVJDSwwwiCURk2z8Htj?=
 =?us-ascii?Q?fleCtPO6UKyx21ZhuKDQzZvuvC4cYqeSQ6/p8dZSDKIaT8JOL2FNBPw/Avn9?=
 =?us-ascii?Q?4BswNgU0CKwJJgd3g+Vu+ZU3fKkWK5LoWF0WJvEls5TNS3IiRBT7k1BfsKzV?=
 =?us-ascii?Q?QC0/laR5wej+h78aRoqn/0R2Zv16C8XQ1AaDh19QJeTkOLoaQKJHzVswnYUt?=
 =?us-ascii?Q?2K1u84ke8zngYo8458E7Tb+esxMLLvZyEOMhNEb2iesfj+eZZ5J6YwBcLnw9?=
 =?us-ascii?Q?CMTC6lMZZAAv9u8AI5b9EKqqvGlta/oH4pxZqYTsZGSyV+XR/UAl+OR2VA/G?=
 =?us-ascii?Q?0dou2kkayYMOGVf38VLZaODV/qJjM8Dz8NAW4Hdi9IcBNl+fgzVvh38/993S?=
 =?us-ascii?Q?P0l/NKys7QyQDdfYnuUw23g2Bn9dizhUcRusX/FiwJWsDL3zDljx2HUQQbt5?=
 =?us-ascii?Q?YRp5bcLUkTd/MNU6lzRCijjdI8IQ4VNQZC32RJ2K0eBfh64iZCA1wbsazM/O?=
 =?us-ascii?Q?lBFzpJovLh3LSiLuJ2oYlSLwEE5GQIUUTDmMRd2HBBn+n6yIJ+jG8emiYl/l?=
 =?us-ascii?Q?Dz5rIOFWzCPiXTU7UrN4NAyMfENM7fIq/N64uPpuzdQWgf8oyGiU4n6GN0+u?=
 =?us-ascii?Q?OIKTQ+3YaIQ8tPzIsnJznZce00nsfXJ4iCENDrR0PRpeNEbC9pAXOYxFNnOi?=
 =?us-ascii?Q?7wIyBP+tHDLBrjiv6AveBZk/jtSIfn4kqW5DRdU5NzFTCVRVAf40uOVNck+y?=
 =?us-ascii?Q?WWdlzgBAY7dCTtiU4GFART9w5UiqDqdw5jbL/rbRsiRaJb+fovZ9LAzksbMx?=
 =?us-ascii?Q?GthH7R41KA98fD2itldacBS1Z/6WMPAL1O3osovi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cba555b-75ca-46c9-a83f-08de23503e25
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:34:28.2203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNLmeBh0/HWAYnb0hNi2tOTgnEj25dEUYHSpbXjZOkFWjKu179pdM0IvcIWgpJywtDtxsfgSiGfTVb6TbCwVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7223

On Thu, Nov 13, 2025 at 01:36:26PM -0700, Dave Jiang wrote:
> 
> 
> On 11/13/25 1:05 PM, Robert Richter wrote:
> > On 12.11.25 09:34:34, Dave Jiang wrote:
> >>
> >>
> >> On 11/11/25 5:54 AM, Robert Richter wrote:
> >>> On 04.11.25 10:13:34, Dave Jiang wrote:
> >>>>
> >>>>
> >>>> On 11/3/25 11:47 AM, Robert Richter wrote:
> >>>>> There is only support to translate addresses from an endpoint to its
> >>>>> CXL host bridge, but not in the opposite direction from the bridge to
> >>>>> the endpoint. Thus, the endpoint address range cannot be determined
> >>>>> and setup manually for a given SPA range of a region. If the endpoint
> >>>>> has address translation enabled, lock it to prevent the kernel from
> >>>>> reconfiguring it.
> >>>>>
> >>>>> Reviewed-by: Gregory Price <gourry@gourry.net>
> >>>>> Signed-off-by: Robert Richter <rrichter@amd.com>
> >>>>> ---
> >>>>>  drivers/cxl/core/atl.c | 10 ++++++++++
> >>>>>  1 file changed, 10 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> >>>>> index d6aa7e6d0ac5..5c15e4d12193 100644
> >>>>> --- a/drivers/cxl/core/atl.c
> >>>>> +++ b/drivers/cxl/core/atl.c
> >>>>> @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
> >>>>>  		return -ENXIO;
> >>>>>  	}
> >>>>>  
> >>>>> +	/*
> >>>>> +	 * There is only support to translate from the endpoint to its
> >>>>> +	 * parent port, but not in the opposite direction from the
> >>>>> +	 * parent to the endpoint. Thus, the endpoint address range
> >>>>> +	 * cannot be determined and setup manually. If the address range
> >>>>> +	 * was translated and modified, forbid reprogramming of the
> >>>>> +	 * decoders and lock them.
> >>>>> +	 */
> >>>>> +	cxld->flags |= CXL_DECODER_F_LOCK;
> >>>>
> >>>  
> >>>> Feels like this should be something the BIOS should enforce if that
> >>>> is the expectation? And the kernel checks and warns if that is not
> >>>> the case.
> >>>
> >>> I think this is more a limitation of the kernel implementation rather
> >>> than the BIOS. The BIOS provides enought information by CFMWS, PRM,
> >>> HDM and PCI topology. In theory and if there is demand for it, support
> >>> could be added for driver region setup.
> >>
> > 
> >> But shouldn't the BIOS set the decoder lock rather than the kernel
> >> setting a software lock flag based on assumption of the PRM based
> >> setup?
> > 
> > If BIOS locks the decoders, it cannot be removed even for the case
> > there the OS can actually handle it.
> 

> Oh so the current implementation is auto region by BIOS but in the
> future it may not be? But if you add a lock flag, you wouldn't be
> able to remove it later anyhow since it's presented as locked?

The BIOS provides all necessary data for address translation, so that
decoders can be reconfigured (including normalized endpoint
addresses). There is no reason to lock the decoders by the BIOS, as
otherwise, with a capable kernel (or other OS), it would not be
possible to shutdown auto-generated regions.

However, current kernel implementation does not support this and is
unable to create the region. That is why the kernel and not the BIOS
should lock the decoders.

-Robert
