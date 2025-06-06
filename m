Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B9286D45
	for <linux-cxl@vger.kernel.org>; Fri,  6 Jun 2025 09:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749203090; cv=fail; b=qhOt1oOtgU/WNCO6m/pkSo78TtV2Z9oAeyU07+d+jZUVOQK1gNYH5l65fYywzyb3WEUcZkLg0lYg75gf7CCqnA56Um/arZJIkIHhDJlGyrRmWkenDfyRFtDZUH4sypeRFf+7/0j2tvMWpsNHerag8zc9NeLMs6bTg+oxeZc8X10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749203090; c=relaxed/simple;
	bh=GdrlDpWTp7v26oqMujakUqXX/qmSpyL5drV7Nsse2gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GUZ7aOk0vSNsdokVGOY60WVwNx9TQTq19LNaAegTnvIGfyJD180WKfDeGDrgiGLUc8K6pj/2q96obVAfmHv9WWSMEjS/lD4a2CQ3W4wc2cnvB6LK5SaT0xVbhtxIhkQ+Gh5QZxnnhHWndmgo/m6NzPLEH+aVpWd6H7YtOmcon4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JJTnhymI; arc=fail smtp.client-ip=40.107.212.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JJTnhymI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvugMSuvQ2qgbpRrtq55He0P/nIIDIptSzRw6fRGOh5eNOQvL9DTnFAqLRT6BmZvC1ytTeaBYZvCEwh2LLeTCGKBR1c0iPt6NYLsCN7XAggzkxy9fzsgkoyk8uCnqXWxw2aVJXwIC4/jj7kppfQElo1kn5ZoR6prFuKXyzWPzrHwZvIpZUmskErDai2+NkeElY9DKcA64c9sSkOTGlKXxhm91kdzV9vm18SkfsBEV39bpusI/CfTbX+I00PK0utuGEOq3z6kr6NpHj2CkgT3WAf0Jo++KCdLlTiiQe1AmTv4IAotn3adVrEsNuK0kZt+3KvCiFRuowGCQeMmhI0Z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znyxwRNVXdMTHu7SWrSWTxYvBvay6+Fj9pNyuEzGN+U=;
 b=ym76vp5eFYzoBA2quDygS3K7kiVNeuJSaY9p43+JrHH1UdGef7R8VWkQDxZn2oqZD6ktSkk2+5TjFkcm6jvoeCqoE592d1AySF5iIPwS8nwLX3JcBNfQSNGIZzd5vJ3Ujunq11vGhnLNgepkLr67HO35AMfFSZawb+a+Gh97dgGH6VTasBIfReqYzEOowdGh1qnoGZiQJmNMO4pTMnb9lyefgswgNMFwqQnybd0Ta4inkulvWDPc0zIyh74/KhZXz/arl/9smJ9BE03mT0zs2wc/yN2An6FIKQXS7/orMy4Cn2oht+W8aCQ/8M392U2+H4ZGlXgqgp+M40wa4b+XVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znyxwRNVXdMTHu7SWrSWTxYvBvay6+Fj9pNyuEzGN+U=;
 b=JJTnhymIYVSD151h/iuMNNRLRox86iapl0jtEVQAPByWKBT08vMhIgdy7rGVn5qUc0VNVq30OjinXkEPjhJBXtrX2+tD09rtoiaQQTpJCnbVTc3aC4UAFDJtzOqbPoIjjGb3laZ0CYIyEl0Aj0b7XX5vloz2avsuZ87FvdxBPNM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.38; Fri, 6 Jun
 2025 09:44:45 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 09:44:45 +0000
Date: Fri, 6 Jun 2025 11:44:39 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
Message-ID: <aEK4hx6wNkpvYK9K@rric.localdomain>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
 <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
 <aEBp30k03GP46eBd@rric.localdomain>
 <026e7506-b248-43bb-9118-5e3c3d817c90@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <026e7506-b248-43bb-9118-5e3c3d817c90@intel.com>
X-ClientProxiedBy: FR4P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b002acd-ff77-4b0a-31c5-08dda4dec52c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPrXF+D03KJ8srHTb9Fv2oxlceeU6h2JLQTFHglGOS/MBGSo+fkxef1oHMw6?=
 =?us-ascii?Q?Jnq5quhd2tnklHZ3hPwxdwmEqY5fCG6K2SBLlYXy+ws3s6m1ri4jQpbO37xZ?=
 =?us-ascii?Q?p4Qc/m/JRznQnjJcM52HIJTVO/J0YTenfyJ8d6xYVEKBts3LfSVsTGajydCZ?=
 =?us-ascii?Q?YdfVQ5wGWwJlXm3bKzTcXkviblMnch5EteNdUiggFjcC4d33jrdwVL+zlCwf?=
 =?us-ascii?Q?1Us+438C6hJAreKXpwy2Sarfa2WcwgXLYTsL/2EaC6xph3cHwBvkePnBiYXO?=
 =?us-ascii?Q?aK1f1R2nCtwv8ykIJXER0uqq7B2vK5LBTzuMa8rQ2Y6/xAGquTb2kktp6SRd?=
 =?us-ascii?Q?au26aoWcC3MhkSzF2YH0G5fMmY2tReipo3ILO4NOeXieSVZ9JAQC82HnXonQ?=
 =?us-ascii?Q?6NpX/s4e9CzWB4q5sxmjQlDrF5sx+k/bSNdHWlceRlM8h2SC+KyObG6KpucW?=
 =?us-ascii?Q?3PKoEu+8V8aLMM84Jerk0yVq6l9oy3JiR0GksZxE0Y+FYT+OZHWkse75hdSr?=
 =?us-ascii?Q?NP3Mj5fR1L6OLcFXtIH+gxjbDb2ydjYBlvlr5h951zTFO3dpCBhhW8ejnCUZ?=
 =?us-ascii?Q?OWGD/2pwG5uooMRgeXvnBYF/3NyhE2K5NbfhHM4CcS6Czc5QJFSLTvYes09i?=
 =?us-ascii?Q?c/Q+HSoSLFgC0kY1phQ4JbJSDJ5GeNNonTukukbF10l0ZYj7VDHmqvZ4STjo?=
 =?us-ascii?Q?Wlvdr+q+lIYdKS+Nlw8b5ieqIZpoxgSJDDHcvubPnfQSKOqS2QE9TAIbvDT6?=
 =?us-ascii?Q?w9e3Za6s4wdniYofobhYMwb52jpRA7Bh3MiPhMOf4YACrrXZChE/c7TbLHfq?=
 =?us-ascii?Q?XQrgF12y66xJYiRR9CVuSqkQ0WUDRWFWNhGO4HnIUBtpJrjAMzE69AOIUKIa?=
 =?us-ascii?Q?Y9+66Ey7DH10xLUk6Y7MhT4q84hki6unzDqGZl/rPW9jTNv8yn+0LTeixP1H?=
 =?us-ascii?Q?7e7oihl9UCXSQPz3SnfQwrciFOYziVUJXIwuCzi9sz1+rpsqXj/blY+CqqD4?=
 =?us-ascii?Q?+cdhhuf99kmtFrUaJ4HG3t/PN4UKEdlj5wVUD0KXw5/ts11g/1ffRK2v36dD?=
 =?us-ascii?Q?0D94dqGT+8SVO7MvhD6bhk9uZiG1KrhLMLgUOzWmLIebEY7ac1plrtblfpvB?=
 =?us-ascii?Q?CedyDIjR08cukKeqmY2xVZHBv04rfYyYTc4i93E+JuGmuGm5dUQKrKPXBbpr?=
 =?us-ascii?Q?PK01iS3XDqEfbyt0PmUzohX859fC88sdMtkhTZRm/V+mEskBDB7fhzQiZPcO?=
 =?us-ascii?Q?aXSl9gX3ZXWIZHUkBxXx77/Zz6VNjFTP3GPGyOq14YxXkJZWHhgvclASR8jH?=
 =?us-ascii?Q?D3evSQAEs4m935Fl/nzBZNfL9uZUGUgO2N7tDLATF0Mcm7LvkDTvfe4IwQiE?=
 =?us-ascii?Q?elYE8NFCdIabpWrbRv+eBc2FMRk6+Cw675277kfmWUEnRN7U4nR83o4AfAQ5?=
 =?us-ascii?Q?qTTf02yVyDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFeoICR0y/4M26rUwePc5DFT4NrF5eiVUhv9NjkAEu2vVQwbto4wzEi9ch2F?=
 =?us-ascii?Q?xTc3DzzsDF4nwlbDC7j/4GPCre7InCeO1YyN/Z2425IQZJwcnDEh+RKCvCuB?=
 =?us-ascii?Q?cmKQdiwb/mVKDTd1H9q6Q/8n/4YNS0B7gvhMoxjH9sjt0inekkdK5QqYeAsv?=
 =?us-ascii?Q?ABpg8hq+/uovbsikVZ+G5dmqN3R4cdKcWIMSVqZQeIYMqc0OUidaeFUFcWTJ?=
 =?us-ascii?Q?VMqre3Z8u7ZxWVVKPRdZgobvrqaLAvTsby7xHV5kBM/FEki9Ep4Z5rKDavDD?=
 =?us-ascii?Q?fsxZYc/8g7Z9SBgzBIbgkyVqfimEmk8udR88Qd37hP6KXhm2+01cvsXjVyMS?=
 =?us-ascii?Q?VnxwA35Aziz1IAsDTic0JnYT45Q2HwXS3nABOUp11NZDo+6wj3gmXOPLXb67?=
 =?us-ascii?Q?wJBbAl4IiuDJ8pITT5+LlYgwz/9hZb/LzrrWtm6EJ7hb+6U1sLBS0Xnh5GaL?=
 =?us-ascii?Q?q2bbWsWUMwn6e6XWGASOkaY+8rdvup/7L9t4IKB3sbvqxf3evXetVXSyq2yY?=
 =?us-ascii?Q?talnVYkG/dDz9SzQeL9KsVwsXgyqgSxRNucqvnkjLJ1rO4V1sH5sFe5Z2/A0?=
 =?us-ascii?Q?nEBddXZ25rE/KOq18K9Vp/og1vfjs/ZESSU3/+2CmImoaKbnpXex8H9JvceQ?=
 =?us-ascii?Q?WhwktM6pYmepmN0HToQW7xze2dP1laOUrG3FkYDruZEKMotPX0s1NHw5VkX6?=
 =?us-ascii?Q?svRGkRogLiWWP8vee7wZqRQABFPDde8wvtl4+NRKJZxUqLtCyXd7TvucL+J0?=
 =?us-ascii?Q?/EGUTjNmKuM80V+gvcba2RqwaAJ/OSx9jj74gMf468UGIzzZ4ZNfUfV+qBFe?=
 =?us-ascii?Q?/unLQdpww2EZ/E2ogJVvXOHQDgL1xA+BRHBK7gCKSf1gTLMkVzWS2egXcK8F?=
 =?us-ascii?Q?7E8Oms79T8YV/NXwbt8dR+S70Os6if7keaqh6ShDPgWW3WaNFQJfNBhMHlmr?=
 =?us-ascii?Q?QB68mK7fvcBn92PLSW46KlwGHCf/9aooWG8uoS6ss68QbheN6RgRI+9/tAgh?=
 =?us-ascii?Q?3I/djWMMkRu8LRSYEOvWhPgGFYOYcTE8ITxIDFvfGR4uDwW3Oa6s6U4i0kX1?=
 =?us-ascii?Q?4egv/UGEhtyCaHhawZGggvY1F5pFaNG/xCHbCRiyzryRqnHL67UuC+b9Teae?=
 =?us-ascii?Q?J+FKxl+l81qX8eiRCtva3I01y8ssKB4qTmcoJKQjawc3CabvscGgeGxhEdA4?=
 =?us-ascii?Q?d4CuGbe06+mN4FwcoKzRRl0emkOr5BEJej/KVUioSuZdDRQGwjIRWsx5J3JG?=
 =?us-ascii?Q?Cbxqj+xmwQwq8dsOu/z3/TASa7s1N+EJn6y6Cx/vpf+Jgat9sczIZGFczuKE?=
 =?us-ascii?Q?9k9eQeNDoc1XtXs83Gi0LdEgTYJ4eWHCuv4vC2yepH20JTDN1b614DbFyx8E?=
 =?us-ascii?Q?9k9xz7/5xd4iZ+V3CizbSYi4Yt7cQAnWIiKeTxcXSD2JUwUj7WVjsZ+iS+k/?=
 =?us-ascii?Q?Kw441yThVWT4LDaUJb7qQqb8vOqxC3MttA5FUrw/j/KmcevkFFQFLgzPb4dt?=
 =?us-ascii?Q?uAhiK/q83q2JAZJAqewbuEW0Q4uGD3xzBFXxRHOtM7PZZkUQwtPKMM6B+vPe?=
 =?us-ascii?Q?jooIsrbU2pDiIzC6CyhMj5OOtpyuZbGQRFG/hct4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b002acd-ff77-4b0a-31c5-08dda4dec52c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 09:44:45.5505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bt0k9G+2Ofy+bG4REqlTKJIqIOFUiZ/f/Uk1PZCn3H14uVimpMurEn25rNkASjO8wqy5b+Cw8b+Bf0Sriqr4Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

On 05.06.25 08:17:17, Dave Jiang wrote:
> 
> 
> On 6/4/25 8:44 AM, Robert Richter wrote:
> > On 03.06.25 06:55:15, Dave Jiang wrote:
> >> On 5/30/25 6:51 AM, Robert Richter wrote:
> > 
> >>> The port_num can no longer retrieved using sysfs. Previously, the X in
> >>> dportX could be used to identify the port number (former port_id)
> >>> which was identical to the numbers in the sysfs target_list entries.
> >>> This is esp. useful to reconstruct the decoder tree and map pci child
> >>> devices and its decoders to a parent decoder including its positions
> >>> in the target list. Maybe create a targetX symlink from the decoder
> >>> device to the child decoders of it?
> >>
> > 
> >> The numbers in the target_list are dport->id and should reflect the
> >> dportX. Is this not what you are seeing?
> > 
> > Exactly, but I would prefer real numbers for the target list, that is,
> > uid and port_num.

> Does it help if we export the port_num sysfs attribute? Is there any
> specific usage that you need the actual hardware port_num?

In the target_list attribute I would expect the actual register
content of the target list. I assume tools rely on dport%d being the
same number as in the target_list attribute?

My first preference would be to delay the creation of the dports. We
can then work with port_num in dport%d. That is, only create it if the
link is up and a port or endpoint is connected to it. Everything
remains the same then, except for when the dport is created and seen
in sysfs. There are other advantages this has, e.g. for the driver
implemention.

port_num would be an alternative, but where to place it in sysfs as
dport%d links to the pci_dev already and dport%d/port_num does not
work? port%d/port_num does not help either as this would acutally the
port num of the parent port for the link to it.

I thought of reusing the target%d scheme, but that is already taken
for the regions and provides the decoder device string.

So my 2nd preference would be to introduce a link%d attribute with
port_num as parameter that links to the child port or endpoint. E.g.

 ls -l /sys/bus/cxl/devices/root0/link*/link*
 ls -ld /sys/bus/cxl/devices/root0/link*/endpoint*

would give a quick inside into the port hierarchy. That also helps to
easier find port children.

> 
> > 
> >>>
> >>> Due to the different initialization order there is an odd port
> >>> numbering now showing up with unexpected, out-of-order sequence
> >>> numbers, e.g.:
> >>>
> >>> /sys/bus/cxl/devices/port1/endpoint2
> >>> /sys/bus/cxl/devices/port1/endpoint3
> >>> /sys/bus/cxl/devices/port1/endpoint6
> >>> /sys/bus/cxl/devices/port4/endpoint5
> >>> /sys/bus/cxl/devices/port4/endpoint7
> >>> /sys/bus/cxl/devices/port4/endpoint10
> >>> /sys/bus/cxl/devices/port4/endpoint11
> >>> /sys/bus/cxl/devices/port8/endpoint9
> >>> /sys/bus/cxl/devices/port12/endpoint13
> >>> /sys/bus/cxl/devices/port12/endpoint14
> >>>
> >>> Still, this is correct, but maybe we could force a specific order
> >>> during initialization, such as per-port initialization which should
> >>> result in a defined order? Note the shared numbering of ports and
> >>> endpoints is also confusing, maybe that could be changed here too?
> >>
> > 
> >> I think the upstream expectation WRT sysfs device number enumeration
> >> (for all Linux kernel devices) is that no ordering should be
> >> expected as the devices are initialized async. And previous ordering
> >> appearance is merely coincidence and not the expectation. And the
> >> expectation for user tools is that they should not depend on device
> >> numbering order and identify the devices by other stable means.
> > 
> > sysfs still is human readable and for good reasons not some binary
> > blob you need a viewer for. Avoiding un-ordered enumeration where
> > possible helps understanding the topology. So let's think about it and
> > if possible find a way to get a defined numbering.
> 

> I'm trying to understand your pain point WRT to why ordering is
> necessary. Is it somehow breaking your user tooling? I'm not sure I

The expectation is broken in a way that Port in the LnkCap no longer
matches with numbers in the target_list attribute and with dport%d.
But I don't know of tools that break here.

> agree with the thinking that we should try to design the enumeration
> to make sure that the device id number should be in a certain
> predictable order, especially with the async nature of multiple
> device enumeration. 'cxl list' should provide the human readable
> hierarchy view for user understanding, not sysfs.

cxl list only shows enumerated devices. Will check again if that can
be used if the setup is incomplete. In general we should keep the
sysfs structure simple. I am not saying the must grant a defined order
in sysfs, but should keep it straight when possible. That helps
debugging and typically improves also the software design of the
driver.

-Robert
