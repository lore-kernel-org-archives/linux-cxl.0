Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955521DF248;
	Mon, 15 Sep 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921505; cv=fail; b=tuoQf8MPgR9VrX0giIvUmtrGJmHVwUyYuMNkfQmG0iIjYdkMqV7DpoEOv5Xs871gZhBuPm/6p/LrtvPGBEaCk51PfPo0L829U3sYeFVExre28H/Lt+VhW+nrhudNd+M2LOYrpGPJvQwrhO1LsZ7/wlzZcHt3+m4ktM7WBEkikOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921505; c=relaxed/simple;
	bh=rkflCxgavBMeu1QapkoMO+P7BpB3NdXl7RocmVsYF9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WI0+6nm75zH69mhLpW29IAhZKa9Ep3Ck6ntYJATRvywYBDu5jFOnQfisDyWxCb+DSwef4DaG69dp4W2Y4gndAbCSUQUYYVU54OB2L4bBvu2MnrS33rB/Gq/wGoAGZVzy1xzn+E0WwEDw+98LVVpwJop3TK6ozxPPMKyMH9LuZks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aOLLRYpq; arc=fail smtp.client-ip=40.107.244.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aOLLRYpq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LjUfZ/Bhe9rIL18exq3yUSOSXKnxpp72pQCeFWc2ksXVRtdmPbMTQdlqopnY1Uy2k7+oVVPM3dV2dDJaAaCK91kqPVATP/uQGavNrun9c8cdPdkvD0ehnuz87rASLSqs83dW3s5NYwGAxWC18ZBa1A4AXyBIfzrVgMZYCWLWDNE+zwzc0E1YL1LyJcqJWbZnyI0O/dSAtYj9QH6pBJWS/ogFetZ6XZoxCYqRYMinM68Mk44+RJNk403tA7ZBoYALdk5iN1VVWfsCHMe/vq8Kj4TYE2H3EI6lQKxIrXE6U2QTfSzzzNpxRMp7Goqg4FbGcdvv/tvE2LZYN93i9yFyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IzzDOFblPZAvdGe7rSyRVW4e8hfLKbxEfkhpXz3upJo=;
 b=TPT/F84hEgGnV8RnabQhLmbsV+AYQ/uC95V3i7s4GQ5PPEIJ1+u68Tp7mdUHi7buHI1i9FuGTzdvV+AljL9rPcJDK2t81ve/kH7l1+AEmrycM2JnRCazCesQ5pci8NmK3INb4Wktlviml0T9Q6H4eZbqZcxt+waB6bk7lzga+/SSCL0W/RPhKDpluvTHAnWqNjvttzYZ1fyEfNhOSleCtdUheKYj96aNgHqWV65bX8iVqSKpJnjTqUPDRogrcV/IV+Ww2Ce02m/jlclr2GpDEsgGtzCxsSPF/6RgKgiZhdh6F/tWn0fiLKPDrSQNxxRmccfBOqYw5m9OWj4BcHzR5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IzzDOFblPZAvdGe7rSyRVW4e8hfLKbxEfkhpXz3upJo=;
 b=aOLLRYpqiWRrcAmxRmvqNSRiJZuBVv+zERpPvKZtrcR+UQlDDXlYoyszyUHbIcVDS9/d06RiKOvSbYz8u0+LIMvTGaC3VdIXX/QjBe9QT/m5ZrXy0SuBtrDS7JlpKfNVNA4uvKQOlzpQf/RY/i84r2N/1YnAjkU8+L9ip3GOdaM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM6PR12MB4153.namprd12.prod.outlook.com (2603:10b6:5:212::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 07:31:41 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 07:31:41 +0000
Date: Mon, 15 Sep 2025 09:31:34 +0200
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
Subject: Re: [PATCH v3 06/11] cxl/region: Separate region parameter setup and
 region construction
Message-ID: <aMfA1hlZWfNdnEy5@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-7-rrichter@amd.com>
 <3d44af04-f7d6-4625-b07d-40173bc95c35@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d44af04-f7d6-4625-b07d-40173bc95c35@intel.com>
X-ClientProxiedBy: FR4P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM6PR12MB4153:EE_
X-MS-Office365-Filtering-Correlation-Id: e58a061c-14f0-4dc1-7283-08ddf429ea18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5VMlumGSYAFqoIQY4vtP6PjXqShooJYr7mfuHoa0UZ7iq0gRnKCHk7c2iNg?=
 =?us-ascii?Q?TjitYFgSt+vw72E3IS85Ru2Hr7sxzP0i+O6AIcBJOXY+XS+QoDPpSJQtNCUB?=
 =?us-ascii?Q?HSCbGxi5LTZx064i3TeoyW8XhAQKLbcSRtTFwk4uapz8ERxr9t+fyAvWpdox?=
 =?us-ascii?Q?fPw2zsp/FePPU7nBNIYabpqHgwCazp5FhQsplQUsyubCsTS8TpOVYkFvEMiS?=
 =?us-ascii?Q?bELOtiqBNP1rcW10itCkISC451wS0GZn1EmuUqylEIppkpPWOV1yILUf/GE3?=
 =?us-ascii?Q?T6ixW2OPp9WyM0c344vXqqFtFAhDH2hvOfo2M+5RKZrDBMyzkmFp6xJwRUCh?=
 =?us-ascii?Q?FfRO9/1tsC8ZKuXoHextcb6/DXdRGbzoFmsZWVNXS1348U+bkYPHr2ZpUAut?=
 =?us-ascii?Q?L1Oo4PD3Np761MVWWsQEQ5OvbUTei4e5z10nbahKtLtQd697nEoqO18o0McI?=
 =?us-ascii?Q?DP6L8dbqE2zZXqMXu6W/N8GSTqB6Yrtqbajq16a+YsKHWz5+aIT3N0mdmYP2?=
 =?us-ascii?Q?a2rsA0ys0gudfag6ZwbFEbCn+bOJeEJ5V0HxetD8UfhmhyNOB4y1/KojJJ/G?=
 =?us-ascii?Q?A9NNOzA8w2wvT336haRxfnN7c/9KwpTS5QzENw4mNq15yCOtVwBHj3mpvOJR?=
 =?us-ascii?Q?pRBFt1veaz3WWtrsIIyBgL70y5psGWoaazF/iZdUKt9qJr/8VX91y1ELQAEO?=
 =?us-ascii?Q?83DEJreh0uPgMgOvD55Gycn2moQsbTdSDFFWWSBBeIfR9IDp6g+QItt5u5S5?=
 =?us-ascii?Q?uOyGtxhzlxisby1g2diQZmJrW5xCyQxUy0oBA9bhSp2EyMuiCwJlWO70BT9V?=
 =?us-ascii?Q?CdUdk3JpEqIX773WZm+OMIqm1idD+M9ucOUPnc1A5qxQGYR/OXautBK9MbBC?=
 =?us-ascii?Q?9NUuP5hlvrMXRIoopI21Esy4KRTRvucQZGMLPDlYl9F8NzHKRxFCsG1RCqh2?=
 =?us-ascii?Q?ItZYu9WdpNqKoj05de09YmOLr/fk+YEnEB+7emAqHfAMaLaXH6MOtdLaOU6n?=
 =?us-ascii?Q?3nP2Yks4t/QntDZpKrPVvoMgx3qNptDh1hVk0+qJqU6PVJ5VDgaefWxE7mTe?=
 =?us-ascii?Q?ubRZZgoTHQfCUDH8lqU19lgY0N8Z9TRrgIPSsQ4L7+5L+BNYAA/UNo1bJ4ca?=
 =?us-ascii?Q?XslpoAgstu0j3MFO9I0cUCyoHPEc+6FEA/IzwXz/gfjFYZ+jcsu6sP07aqre?=
 =?us-ascii?Q?jSC16vifZbc6Faelpd55PsYv+Cgg32yBVGmWKjh0v9AMzG2R3vKN6HJZYy7Y?=
 =?us-ascii?Q?3+4mJcMz++T8u41+63WcHLZ8ZuT1Dl8G/3/5ZFLz0VWjIlQrI/jADig6S+6z?=
 =?us-ascii?Q?dOXEKkG+Ts9BS6vyWU6Z2UY/6EK4mavzNiHvD6RJYGauCeDYDNRmNRUCjA60?=
 =?us-ascii?Q?ctsIr1daDDUCkDgZIXqCJO/5VeSn4MOasog+5QL+I4rs8/8iAjbiDXZMbHja?=
 =?us-ascii?Q?fmTqLi+xSdM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIi1i66vx+Akc9JZ8k0SvxY1y10hSpdvVz/+cfPMper4sUh2hCRTRbVLPBJ5?=
 =?us-ascii?Q?Nf7a/i+0QE2qzQtgBBPAl7ipYZduESWWG+hK76nYVfjbxdBaEZUGDAEpaDt0?=
 =?us-ascii?Q?k2CtDWA4H85W4H/885+nudSbe4efgVPU3TjpJInwQWvI40OhlfQSV2FMXQTa?=
 =?us-ascii?Q?KXK8gC6Zzo5UKaxND4CsYwUx0hwsiwPCorQdUUpFh1ZSFHaMbhjAe9B8A8Dn?=
 =?us-ascii?Q?0/vlK2VP5DPU/nujkIjGEu7U18FqY/YSEY7XVNx170741B8/DaNDh+vwAWiU?=
 =?us-ascii?Q?v0eIAe2kghtjX3nygxXRlzO1SAci6UbKfILSbQ3PfqmRaSgXRxRIqztscjZ6?=
 =?us-ascii?Q?Kt6VB/RZjSBGNf+A1BQdLXPtZ2u9P1Lw+PBNvAbyZf7GApTje/oeSCRBMHJ7?=
 =?us-ascii?Q?mvGt/+MqOcPcg3Oei3vf3kN8mi51ToDDkfgOFx6K9PC6uTVX3UP71hGKn6uh?=
 =?us-ascii?Q?DPobNP0Jt9TXBIppCiKi3KPHI2qh35E4aiKpeDG5WUFC0BcJ/EzByp6yUG9e?=
 =?us-ascii?Q?sv+sH26MyqS1jiRPGaHZy0U+XWDB96Glhi80+dR6F1PDZ6kK9TtelhPIoqlP?=
 =?us-ascii?Q?UTpK036eYaJsGh2Dxg8OTLhJ6I57zwoawGHKCx0cv8l/VAJz2drPYUDdFGbN?=
 =?us-ascii?Q?HSasMc9v9oY3Ah2485RDEecEKGBOoScrUg6XJsrEU7wbCHRBYPzmLSrM9yMt?=
 =?us-ascii?Q?mBopx2gwAQO01wc8Y0QZcd3N9emUCn3akP9AIVBd11PaKP36Rwa/8v0veoLm?=
 =?us-ascii?Q?QVsa2pZRwCwofXS+jd4VCJRcoHqQwNM8wrXkbDdhwl0ViH8jya50WwXG9JmK?=
 =?us-ascii?Q?zKxSSUxS5PWPa5T6+9JsFbuZJfBpSu6K3mevjqEEr96TVvtmc2wgLT+G48ld?=
 =?us-ascii?Q?9URuVDDIqydxWYcVy1lb+FonRH6g0ykj28Jt0TG+SJa5S/g6UkCvPdqLSqkG?=
 =?us-ascii?Q?/5gfc1y+rW1ufcX1SvkDMKxj3ov81hBP31mg1z/iNZsimUhIZJ9ytjrkIRH7?=
 =?us-ascii?Q?NMn6Lk0gh6+jGvxu1x0/BufO4Ykrw4o+2+FBo5Ob+OGDHAdVmEa+VykeVb1Y?=
 =?us-ascii?Q?R2OuegJbGv/XtHSmXV/k0hI0krJR68TDgGveZSEWGW4zmtwuTvCIsozv74Ca?=
 =?us-ascii?Q?sx3HDcx9Q75/RjE/gmD34oA8M/NJnbOXiODX51F394prtWkM5xD5YjBCVBvu?=
 =?us-ascii?Q?/pnmd5euVVhXD+9ulA0yy+EAnmG3BKCcLAD3QsqIQFIM+C7tZaAO6kUFmXb2?=
 =?us-ascii?Q?RImmdxI9oOtA/CNxPZn20RGdPYcF5x8Qs97/G2MAJg9dTKUpW91kBMW77Og3?=
 =?us-ascii?Q?ad7+L6ZmOvPHAEuRXIFIasfaINNl3l6eYANHFEDsRdQGsDfuXe71zgn6VPAz?=
 =?us-ascii?Q?45WoTFlFhlqDClNfRXF8dxAMnqGMKKM02/ouTYvhpEV4GBxj/BfaCn5j7KHo?=
 =?us-ascii?Q?YjJdn4oQpfz5YxyHdrYVFQz8IMupvdSLVr/kTdJdGAfFQAD9HbBVpmf1HeqS?=
 =?us-ascii?Q?CqSccbZAMRuABmdsppH9fkGG2UU/djLDCoel66HsQ/N8ae4jSygM5GwE6xF4?=
 =?us-ascii?Q?/U8+WFxv5UE05RODNFHo6wFdMSTG2I+gkxSH3thq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58a061c-14f0-4dc1-7283-08ddf429ea18
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 07:31:41.6002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B0e+WrB86uM+RtfuSi8foXi6eD7UPFAInpirD77Wqj99zjgqNhbSRdOI9NhO+krSTW3Hnpg0gVR6iNThZ2FvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4153

On 12.09.25 14:10:06, Dave Jiang wrote:
> 
> 
> On 9/12/25 7:45 AM, Robert Richter wrote:
> > To construct a region, the region parameters such as address range and
> > interleaving config need to be determined. This is done while
> > constructing the region by inspecting the endpoint decoder
> > configuration. The endpoint decoder is passed as a function argument.
> > 
> > With address translation the endpoint decoder data is no longer
> > sufficient to extract the region parameters as some of the information
> > is obtained using other methods such as using firmware calls.
> > 
> > In a first step, separate code to determine and setup the region
> > parameters from the region construction. Temporarily store all the
> > data to create the region in the new struct cxl_region_context. Add a
> > new function setup_region_parameters() to fill that struct and later
> > use it to construct the region. This simplifies the extension of the
> > function to support other methods needed, esp. to support address
> > translation.
> > 
> > Patch is a prerequisite to implement address translation.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++++++++----------
> >  1 file changed, 38 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 106692f1e310..57697504410b 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3414,6 +3414,26 @@ static int match_region_by_range(struct device *dev, const void *data)
> >  	return 0;
> >  }
> >  
> > +struct cxl_region_context {
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct cxl_memdev *cxlmd;
> > +	struct range hpa_range;
> > +	int interleave_ways;
> > +	int interleave_granularity;
> > +};
> > +
> > +static int setup_region_params(struct cxl_endpoint_decoder *cxled,
> > +			       struct cxl_region_context *ctx)
> > +{
> > +	ctx->cxled = cxled;
> > +	ctx->cxlmd = cxled_to_memdev(cxled);
> > +	ctx->hpa_range = cxled->cxld.hpa_range;
> > +	ctx->interleave_ways = cxled->cxld.interleave_ways;
> > +	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
> 
> You can init like this:
> 
> 	*ctx = (struct cxl_region_context) {
> 		.cxled = cxled,
> 		.cxlmd = cxled_to_memdev(cxled),
> 		.hpa_range = cxled->cxld.hpa_range,
> 		.interleave_ways = cxled->cxld.interleave_ways,
> 		.interleave_granularity = cxled->cxld.interleave_granularity,
> 	};

Will change that for readability and to zero-init possibly missing
members.

> 
> 
> > +
> > +	return 0;
> 
> Can probably make this function void if no expected errors and only assignments.

A later extension to the code may return an error code, so I prepared
the function interface already for this.

-Robert

> 
> DJ
