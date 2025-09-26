Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D62750F3;
	Fri, 26 Sep 2025 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910958; cv=fail; b=oV8BWO/hw/2CpLNbb9IfBn+4X9LN4JTCCCQbO9q1YTlOBl9/BHwuudvOTEJXlhGzFvtdektKURhi0u42+XtbdYaPfs/ReK7Hpkj3QoBNB22qzE2aI1tEXZ/Go0to09MImdDcWvIFPaHDLRlUTVZasv+jXCwUCWhQltDP/o1L84g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910958; c=relaxed/simple;
	bh=CBLKjGQt1MLi7znstafxLwZeNwDDgNSzLtWWnO9nzds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g4sNqRrE3TuVSkXSOzs/3/rPBrYVeRjPUxFAapEmlr+rLhpG22nRuqVfooVlMAZgtRS9dE8+F4BNOwvGBabTV2JSr7/U2oYcnnv1GHSId3PawRl67J7cIR6vHqt0LwHIy84zBk0FpR3bnn3cm7sASs02VyktgwyERf8CowHC1fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r0h8RjIt; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r0h8RjIt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLsAGhAyyJOO0zEGYq7ExHpWseYg6M50Ni+i4+002Hmlx1mU3bX8urr6IlIbL+sbAiBHTvx6OdweyQvJ3MrJrAb6QM9zAyM9OAM3+5zH3wGrIZRAOxOg2UvvcLn3Yr1ohSF+doj1un7AyWesCcBgqm0OnOiTXY2McCd949Rlh9cJFSxSOq7iODdhx+LKKfB0gGMSc+q9I2XhlM8xgtkg0mhzmiAUx5WV3ZNCRz4VP7XIYWCtZuQJ3MqFRrrm3721XcAEY+B2Xnwez8NRV+qeqdScPBoS6mJXKXwabuu6UAAAOon5e1vCzGREyQBO+7PJYCkUVJkCJk/usHH46DNcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDyA51NNno3Svvf6zA24UoDA9c7ReSHO5u6Gcqv5chg=;
 b=JrxW5e+m+XzL95yOnMFSYwz6Zfivr0fdMK6/b2UEb+rynSvdZa36OyMAjEtRAWPcOj9/ed16OOC4Jm83CNCu/Sen6NKZ2XN7b0HGsMvUX+ruUwYDL04byJ1PmMmog/cE026cqhSlu0e7I9lqrWVYnRDfszbvWFTR0oeHRPVK0FkxDELMvpboxJD227KjRJlgnea6/Roey9cZTsslxLfkayoeW6IZ4to/si27dKGQxOSDF/Bz0oSPFehvo4Vw1IHUnvkPZxNiYDyIKcId9RfCJc2dI/Sh7YUMPd19G1DdCGumitaRVJUfGJsWigxaM+jGn+HTHSQwObKflq6XNgHvHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDyA51NNno3Svvf6zA24UoDA9c7ReSHO5u6Gcqv5chg=;
 b=r0h8RjItOizYiPjdBCtcb0w3DXYQRfbjIehPQVOHIyVGG98CZJFVwgADPqNFs3QdLJY9cS1kp5T1MMPuBC2Zakt+hexCDR0ewB/OHZB3nQRBY6mgwkaFSTddeESsgY2WzJUj3KF4TBgiDqdVplugFL+v6jpUq7yEPLAqNKsVRj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9; Fri, 26 Sep 2025 18:22:34 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9137.018; Fri, 26 Sep 2025
 18:22:34 +0000
Date: Fri, 26 Sep 2025 20:22:29 +0200
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
Subject: Re: [PATCH v3 05/11] cxl/region: Add @range argument to function
 cxl_calc_interleave_pos()
Message-ID: <aNbZ5SgeOAJUhTR0@rric.localdomain>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-6-rrichter@amd.com>
 <aNMWhG5Ftu8ETYwk@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aNMWhG5Ftu8ETYwk@aschofie-mobl2.lan>
X-ClientProxiedBy: FR4P281CA0225.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f02ae4-b78f-4d2c-0077-08ddfd29a9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFznXPjbgk8hESACVbj8tPqU/MLHf9d8mzczRPtHAYkqyn3hzZDPVWYko+0A?=
 =?us-ascii?Q?K8RZLwW8DvsD22qUsH2BuEkE45C+uV0BClPptyCKgIpaj/kQqGVVHBr44/A5?=
 =?us-ascii?Q?uLdUgWVohs33waiGW8s4ZlUXmPg66Wx+zvuACFcSB6owDG7QkWQVhaS0eUO1?=
 =?us-ascii?Q?NpRCUB+jXEFZKB1QznpMjUJ57avTwx+8AFJ3CT44RlUk0tsODggtxS3Tvle6?=
 =?us-ascii?Q?z3D1/HkvtTBKXvKxZ4aePBBnhRCLNljcYTXgHwhUixpEJPd3lQk+aOv9X8v2?=
 =?us-ascii?Q?oyGIKAmOBbwpGaFXVQafiO4jkNCe9DS4y87eWuM36d0ejRyq1h+SqrcEkR3h?=
 =?us-ascii?Q?xAgWyqTdiPess+XurXHqLPMEH0PL/qwvLnP/IycuOan0Cn5Jq+CRWe8q4M3r?=
 =?us-ascii?Q?Yj6OgK2EJv54mrlhCHYk/I6xtkgA13PJNNXN28Kz0h37VHceQQAVqiMzFtU/?=
 =?us-ascii?Q?qoJR/lEamgHEpzKyKHfw+YWDH7eY66a9mpVQmqjKDSzu3dZmLK1K120T7vFr?=
 =?us-ascii?Q?Lut0OigcRBxNmnhygYkVJ588vC/DJkDB+RG6OPPtLU5Qhf7AOxXwUxrZhT5f?=
 =?us-ascii?Q?HJ0vVZmPAbTfCDXRJeZE2ISjW9QaD8FtuX157q7dC10hW7mPTTarKu4Rhv1k?=
 =?us-ascii?Q?kBCr05kCCRdn6UmQscpt1eHcZJ7O+dUlaeXzo+0ch936k/FVyA4BjEYrQ1dX?=
 =?us-ascii?Q?PIc+8ieUIFzOzK90Qj+U35l/AsuTzNv4ppCXo5GCqFznK5s4wZk8/wLWVocY?=
 =?us-ascii?Q?lOFgNp3Lsjkb9q84konyL3lDz/9dGQmjcP6xNFxJEg/bI6jXmYBs3czCg11u?=
 =?us-ascii?Q?0ES0eLYJZujdQZz2A7JEgiz9QCDfAKzO3JO3NmmoFHuJqqU1FFqh8563RViD?=
 =?us-ascii?Q?4eqE7wbgCTb7IwFvNd2YqWbbVqqlX51C93FhXbjS5EmW36iKkvH+jEG89Ob6?=
 =?us-ascii?Q?tmj2Y55jqcu7i9pBYXxvzJpYFDnsmFGFsT6HzFW/jb/iRJP+UDadHQ9eYX77?=
 =?us-ascii?Q?JOlbhZu3PIwE3bK+ep6YGecg1ddFmZ/UJUdGK7bWQA2pQ9uBoiXNf5JVjE9l?=
 =?us-ascii?Q?3kxhCT2N4L90497K4eWZtles8pSk3ZSToLWN1Wi+JawaqFIfY/AIbnv57koj?=
 =?us-ascii?Q?SnOlvjWU0KtYFQRNl+AcKcAXTKCZpggepRTGB94osP9YlvZhJCX42cngQ0Oc?=
 =?us-ascii?Q?MUFI9I97NbHS5QoXrMlWlLR031rWv1j22BPOAXRvMp0rTq4DLZk6gDjmaCuk?=
 =?us-ascii?Q?VLzC//qGo7Dhmc6tlotKogRFUEVuJ4MQYPmXYbL9CkpMRWiT4z/ED5aSK8Vh?=
 =?us-ascii?Q?EKfliF+j4KgN3QoTUcDVa7GNll34K7bU1glZQfTU9eWw/pr1vySai+Thngzj?=
 =?us-ascii?Q?yUCuP3i3Y4L9BS5vE1YpjIp2CGeiEm4BjWoKyfZIihOnDvu2jnZX9h1dfmj+?=
 =?us-ascii?Q?/OZ+hS19/MhW9nW/c9RIamoYEMbd9XtF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8iZFSlAAgJDBwcHN8uanxy4fpWHPfXsHPYZ2cYMLu14LB5YC5527zj92ycBJ?=
 =?us-ascii?Q?TmBYHL2aa8xef0dIZBCuCyt+Y/oUbXpGt3K5oVKlMZdRotR7uTqH4g3ejGJ8?=
 =?us-ascii?Q?13Fve0CaD9AbyCxHpe+kqp9qxIFrlBqAVlLPmR5Q5PrGqHt5HJql5dSL/Icq?=
 =?us-ascii?Q?94Hv6dns3C471ai/ULsf/xdy3EecOIt0BUn7USBRUUmkBUKDAKnrtekhAsgC?=
 =?us-ascii?Q?/SoVCKOWfo9VeK7V3qQvzsPOA4blJw1F/OUWjGk2HFuvZL2yl6gmltezjgO2?=
 =?us-ascii?Q?lEUyXwhURvg2nafnJV5d53CpPiaptunDlAGUUcbf0m0OEMtNGES5LaIYg+4o?=
 =?us-ascii?Q?ZdJk1F1LaRCuwr1kM6t6D2qbwHA3WVI7a6BA0IGGndRp7QCMek42tZgrsjJ3?=
 =?us-ascii?Q?fNJH0/8QnLazQ3ayRx35GLWtyHnSJeOT/+66yw514jaubSt49BfaMnWjfGBx?=
 =?us-ascii?Q?2jmWPO2zeW7PO1nZ5F5StEdiHZDtl8bgh92KMRubilGoWcuMrvf95IJ93YyV?=
 =?us-ascii?Q?15ikOYqf2+8rnD2ceOHO2AFPM/R8ehu4CBCgXz//n9EnH82YEou//dgAor/m?=
 =?us-ascii?Q?oMTlaRV6yt8AiEBgR8rgWMq4QotkwvXkmipDN3l2+6FEnZJba+XUzaoGERk+?=
 =?us-ascii?Q?VHfg93h+7pPV97jzRFi9ra8boF8Vp/NQKM5WXQW93EiBD8ZqQhKPt+SAR4No?=
 =?us-ascii?Q?ug5B67OoA8GxKPtbLmPcbSJ+tRg7Lu2jYzRotCy6OAGFMhhgvqhJLM4l0TuC?=
 =?us-ascii?Q?MntvIxQ/6Tb5HGcCPdimsYbJLAfhl/koEFwaIXHjOWPXWeZl8bfTxYwDQehC?=
 =?us-ascii?Q?Dj8bEo7dfOlhd145YjPWVUzgqiCBGvxNBJrI5M8mF8vmVE/E7qD/iAHoh78J?=
 =?us-ascii?Q?c1LT8Ci0goPS9IhGJnBcewUWtsRfEi1iX12Ya1hvM8pXHYDlaRuE1D3PnmHQ?=
 =?us-ascii?Q?Yja9zmTggIv2mkVcoicGcHoVhen61a6mNr62J1p9cHO0eb6p2CgFKdvhBbWa?=
 =?us-ascii?Q?BhF9MkMq/sE1wv6dY5DZbH4M3zhi1gk6lLR/mRouvu8Et3z+W5XZC1LnLSNz?=
 =?us-ascii?Q?2ncqAzWwwrhzB1l69dyvfkhPhQp79MiSdfsdmkbSqsvtWVJBKvRiiYOs9fsv?=
 =?us-ascii?Q?OnupvehW8e5tCZwR09HpmW5qVEbY0q4Atk51uBJ1E21z4R/yQG4svUKhs3Ao?=
 =?us-ascii?Q?13KSmjjmqT4+I0KMQ3/mbKP+BbzS2t2nERZrBJlO+n15SS+uySqDHqYT6Gnc?=
 =?us-ascii?Q?EnZli5G2z4UJwdjlc/47UKpbeA4Qx0MSrJZJGqQ7cL4H8gAgIE1oOwoI9z1/?=
 =?us-ascii?Q?TmS7vovnNYa8odhfT1+zUbzuWUBqNFfQ3AYEzO7EbfpPCxqdJxcMED8q0ClV?=
 =?us-ascii?Q?rfUaGy4xAT7UTI2S6ozGhaTFSz+prNON5EvbVTDip41c81KF7pF5SZJ5KpFe?=
 =?us-ascii?Q?+/nBdm53nF83nwoRL44NVlM2e4Lnh+sexj/8zWfekMHJVXrPFJNDuNJYpLqy?=
 =?us-ascii?Q?+/AIQfXLcQiVjpJlrW7XYwxY9BrTBs8YAqOcBo3El0ETo8cltLK83jYv1+Az?=
 =?us-ascii?Q?48NQFz+3Trv6XLjmYAHbbDHeoeSo9A+Qeojw/l94?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f02ae4-b78f-4d2c-0077-08ddfd29a9d6
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:22:34.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eFxfZaNGXObHysb74zPBJfF6mgofB6c6RZ+q13FZbOjXZPcyISV0T9sTvfX6HaUPqXTJzEGnDH//LZXuEnwtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252

On 23.09.25 14:52:04, Alison Schofield wrote:
> On Fri, Sep 12, 2025 at 04:45:07PM +0200, Robert Richter wrote:
> > cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> > determine its interleaving position. This requires the endpoint
> > decoders to be an SPA, which is not the case for systems that need
> > address translation.
> > 
> > Add a separate @range argument to function cxl_calc_interleave_pos()
> > to specify the address range. Now it is possible to pass the SPA
> > translated address range of an endpoint decoder to function
> > cxl_calc_interleave_pos().
> > 
> > Patch is a prerequisite to implement address translation.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 8ccc171ac724..106692f1e310 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1844,11 +1844,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >   * Return: position >= 0 on success
> >   *	   -ENXIO on failure
> >   */
> > -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> > +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> > +				   struct range *range)
> >  {
> >  	struct cxl_port *iter, *port = cxled_to_port(cxled);
> >  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > -	struct range *range = &cxled->cxld.hpa_range;
> >  	int parent_ways = 0, parent_pos = 0, pos = 0;
> >  	int rc;
> 
> Will this work? Change the assignment rather than adding a parameter:
> 
> -       struct range *range = &cxled->cxld.hpa_range;
> +       struct range *range = &cxled->cxld.region->hpa_range;

For cxl_region_sort_targets() it doesn't as the region is not yet
attached. This is the calling order:

	cxl_region_sort_targets
	  cxl_calc_interleave_pos
	    # needs cxlr->hpa_range
	cxl_region_attach_position
	  ...
	    cxld->region = cxlr;

It would be nice if we can make this work and drop the argument. Will
take a look.

Thanks,

-Robert
