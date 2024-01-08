Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB57BE4E
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jan 2024 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zf2A2sto"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmYda8UTpZPOkKjnzX0OOf5n6hk2er8aQYoYHpx6TD8SdMzOQ2PQGim66JYCof8zQyPaOLQgw+KbKC/K+jEyKIAu7O3Y7q+eZlnS030Dle5STTbKini6IwYmBYP1HJPGWg+gceTmw6qHfscA6VvmkD58WVvwTCweX4EoLmKRWf9Kh3tvNfuI+NE3T6md3+TyTpWQq7GQAIoelwfj4VruIm4Mh7VxENAD9RoCckL2PQJOtLQIIekhJkc0+TGlj+fCW298zhbCeoloZcmXYpwXZcD9PBGJl637VNyzOzCqxhVINE7/5PWURDKJUT5HE0UNh2/oM/zZ/f5EKd9N+RbaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjKJv/PU0SKlS7y9N18k9Do2V+eUj3oqvghVLXvo2kM=;
 b=jGYjpkLPG2c3K17WC2clPGLM5OgNRAs8zfVmBR7jSHsp0qX2PitdsRnH0/qeNjUKXztureBSYSxQlqcioMKHc61Sjd3A2Q9n2RRhR2VgimIYvC9JtUKJSJ8Hr1I//fFjeC5rzIyws5YKndwquWtKH7MIyqZwOtfYno8jQkCkYVlw3KEeKaYUH5gjeRg9p08c6oZp5fOaA6v00P9FPe5MSQra4sIhHDl0M8QyvfhTiG6OM8uKMSHGmi8gZt6WossmhejzlaM6z4i1sD8wTwRbrvEcAeaUqU3nuvN8H7p2+F+N+u4ePeOvRRnhlcOHmY6LXhA1J/9wneFvv6P2DtygPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pjKJv/PU0SKlS7y9N18k9Do2V+eUj3oqvghVLXvo2kM=;
 b=zf2A2sto5/UQNTUuhUsUacHNP3pIF7JyDn4i80W6qPw8EyldLoERVZO5usBmxFj80/2rinO/rXhQbD2eEBFy/r+rgzBSS9kLk7eTuU8PTA9NSqVc8zpaJfDp1hb13ZIqNe01p20kIM/b8JBhqwp+cqx9U73yj65RwRp+po5Lnik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB6448.namprd12.prod.outlook.com (2603:10b6:8:8a::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.23; Mon, 8 Jan 2024 22:31:00 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::e46e:7c32:7556:fae1%7]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 22:31:00 +0000
Date: Mon, 8 Jan 2024 23:30:55 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	Ira Weiny <ira.weiny@intel.com>, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v6 2/5] cxl: Convert find_cxl_root() to return a 'struct
 cxl_root *'
Message-ID: <ZZx3n76CQVlevdwn@rric.localdomain>
References: <170449229696.3779673.18384234151739803343.stgit@djiang5-mobl3>
 <170449246044.3779673.13035770941393418591.stgit@djiang5-mobl3>
 <ZZiH7QGDLD8DlRNu@rric.localdomain>
 <659c5e868d50b_127da229425@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659c5e868d50b_127da229425@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR0P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::21) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: e70893d0-eb11-404e-80ba-08dc10997d97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ixHwyX/8LiLl5q4NNgIcUme81QPima5puxtL1dIVHIni8ex7cYKlOLcjXklHy045EJENFn9USLMsZJzQdyisdG+I3vCqjCqquBZaRkFSHJ9Y2tYymChUYEJGcQh+m1R/+yfLpzVjLE4WePa3yEh5BixnkY1QR5+C0vnGw0YFH6mum6gHbjoA5zW1nKXQwf17ybFaRhR48HNeGWiGN+fyPa6rIbTh7zCKhf7eJffBLAPGm2IenU6mNKc7amOW9VhrZz5hWgtkVU+A+boOhFxVihFqIDbkQEDy1RTgG37NjcX+Ufzjx7RSl/olxPQVguevrcOqb28hi08uo1ehvUtljkbhBUMlKK3Ll1niQ8O75VjwudxOypvaOsu0FOZzXUPq3WUTvxz87E1rHWWiwce8QCU7xNQuzFe+ygKrLElBMaia2k14w5BzUg31GdqqeDovy9oh1Pp4kCZLKA044GLJaK4B5+Ixcq9rAMu5Yb5pLXlbvZ2iHv0aBiDicoc/mwzi2Dq2k0j558bux8HIXVkd5VgBkQb0VrB++uguyAlHPTk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(41300700001)(38100700002)(316002)(54906003)(66556008)(66476007)(9686003)(66946007)(6666004)(53546011)(8676002)(6512007)(6486002)(6506007)(478600001)(8936002)(5660300002)(83380400001)(966005)(4326008)(6916009)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L/tgaCfraR7Pvv0eI4nIMmSIzrnXoEcAyS5GgKMeSJRxMEQrh4rvUWScs4Nx?=
 =?us-ascii?Q?rQmu2zkIIiLclPDs2enU0PJpnq5k/Cy89OO6riq4nhu5OBULoFQR75lofbz8?=
 =?us-ascii?Q?BVaTJEEGdl0FR44zuxv3ncJ/7NaPaySyd6JvR9ikNVInuDo0hbgk7X5GFv5r?=
 =?us-ascii?Q?Tu+dgAiHwSOL4QwGLwexNvhtbLVW+5qkgQnjes0tzd+3/1a0Ta0B03sF33Ak?=
 =?us-ascii?Q?KM9uOT/ocaxTT8G8qoN5k1BiWH3Y7ZmGpKYnRuHZSf70DWJIGwEqfYddE+Yl?=
 =?us-ascii?Q?mfRNGuo+fRLJYLwouKW9mN0BidZXY6Pjjd3tcmUq0mUSPVS5NlLlomGBf0mn?=
 =?us-ascii?Q?Y+lOBDghDKQiRoCYz3RIYq9BiqisqPtM0nXTZEYTnGQGuZg8p6zVuyr9DxGz?=
 =?us-ascii?Q?myL3WlPzoLnbVvOj5xeZaSELXJbCgpTk9VKYbjepFHb9w73PkFUvGLTApCtH?=
 =?us-ascii?Q?A4uJzcLi1saHXW4GmU/ahUw1pLNv5Pnv5BPb89T2i0YKGWUhQvT+Q6FSd6P0?=
 =?us-ascii?Q?6NnbPOt7tjsLJwpDVbvX7ivvIVAe0D0/zKXtnmqHoYbeirofMI8LPbgBTKTb?=
 =?us-ascii?Q?mJH+Aq/P4YuKBRWnT+MqZiL2uziTAPvrtRKk8bRhkdHl2b7wbzk7R/vwDfQ9?=
 =?us-ascii?Q?SRIPZzSk47VbfliPCMoUD2ai1YR7dZVATKX4Fs+2pCFSYwy9E/kBe0pb2Mdv?=
 =?us-ascii?Q?LkIAJEYyA7n+kBsNyvvQ2wokDFrnz/cd+LfKFAWZutlp1QhsNRPnqOI3GqB4?=
 =?us-ascii?Q?6c9M/fO7iwLOQt9FVLNXuLvHYOiRtJPPW+HldKO2PCwP0I8hX7SYsI7M9KS/?=
 =?us-ascii?Q?KVzDKRG9gJSh21FgsKJX4ah+AkGxRYwyii1gKbRNS0DM/M4UwB26dBRSTrRn?=
 =?us-ascii?Q?ZjUOU+oUClOZMc0ZvtV2iDy0YiN8AEQ9JHUCXskXNyY/kXLmNdDArEj/JzB6?=
 =?us-ascii?Q?Hq0q1newnANkyTlHWU8i/NaWiKpUEv7Ick/VZ/bSTSH4At3OzRRDmbpwWRn9?=
 =?us-ascii?Q?Sg6/23obetmHeVfSZ+/7Xo0tf3M+TQ/hFBz6F2fBYWhmdsZYmvFQBY23rCEK?=
 =?us-ascii?Q?2+h3mvqy/aUmD+D3D6uNQuEKsIcIZZG2U1OsJtHviYMtDaqx6ywsrAZe22M+?=
 =?us-ascii?Q?+AZqkG3z+U+yHJ575tFAgkEKmo2j2U6XXSvmrCeoXFezZ+e55gujgFKnwcR7?=
 =?us-ascii?Q?z2jG70aeDrt0AoNLD7tcMktJwAOhJyuIRXEasPVcPxkWdF9Wb8JSWOz2yC93?=
 =?us-ascii?Q?a9gI7o4weUfxzLwG1OlW2Wp5VRtZhEgYE9ePAVckBrFPGWlT7dwIojBCBg3m?=
 =?us-ascii?Q?xumagOhT5LbSzMRw2ozV+1mHartGKP01R6m94JwKCecJVgozFZt7cJmzGk5u?=
 =?us-ascii?Q?gIvh157A5Lg3SabyKeJvV+uX8yEasUd9vnwGleAOzwwLb6+snkb+y+rdUmsc?=
 =?us-ascii?Q?zYCFNDdz1Ulh6j8empgQKYl7j1t6/xqriaeR851pJD3x1MXDtMaFBDa+zvqr?=
 =?us-ascii?Q?VtltitDsoZ56PS357Xg1kxuN0MECc/LfVEDbpfPr+dnpbYl7mbaNMkjSbrX8?=
 =?us-ascii?Q?dhhFHMk0Fjs8PvVeras02bNluOjY4eWAzOEBo6Rv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70893d0-eb11-404e-80ba-08dc10997d97
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 22:31:00.5430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAG0eXHAUMlIgRhgntEIcqZ2KJtNr0yUUcRdUhghE8Jh5lSO5RsSYbQTOJ3F4W8IgGIuRysES6hSy7I1DmCd2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6448

On 08.01.24 12:43:50, Dan Williams wrote:
> Robert Richter wrote:
> > On 05.01.24 15:07:40, Dave Jiang wrote:

> > > @@ -349,15 +348,19 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
> > >  {
> > >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > >  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> > > -	struct cxl_port *root_port __free(put_device) = NULL;
> > >  	LIST_HEAD(__discard);
> > >  	struct list_head *discard __free(dpa_perf) = &__discard;
> > > +	struct cxl_port *root_port;
> > >  	int rc;
> > >  
> > > -	root_port = find_cxl_root(cxlmd->endpoint);
> > > -	if (!root_port)
> > > +	struct cxl_root *cxl_root __free(put_cxl_root) =
> > > +		find_cxl_root(cxlmd->endpoint);
> > 
> > That's the drawback that lines get very long. Not sure if that was
> > discussed before, maybe just assign NULL in the definition and then
> > have the first assignment right after?
> 
> That style recommendation was something we were discussing here:
> 
> http://lore.kernel.org/r/20240104223725.GA1829769@bhelgaas
> 
> ...where the outcome I took away was "try to keep the get/put in the
> same statement, especially if the function has multiple usages of
> __free()".

I see the point here. An alternative would be to have one __free per
block, but additional blocks would introduce indentation. Maybe worth
to consider anyway as that addresses the style issue too.

I am fine that my other comments are addressed with top patches too.

Thanks,

-Robert
