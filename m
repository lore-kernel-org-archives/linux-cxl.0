Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011027.outbound.protection.outlook.com [40.93.194.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A9720125F;
	Tue, 14 Apr 2026 02:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776134736; cv=fail; b=KPXiQJr789UCJIR0WicA/ET1F4KPfevxkl7laqNLWkBp6v2Qt6Bp51pGF1fg//BotTpN4VUoBvjdivOhEutArh8PYHH/6tuIRN/t//4vy91uJMuRcd10sklEWUQ3K5B2luS57Ah7taC9QsGRvdP4wEWcZqWk1Yhr0Gkkh9I1MrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776134736; c=relaxed/simple;
	bh=+1vPc2rtVxg5cZHr6KivJaarTm4/auMcxESYQji9LOw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XH3u5PtKalRdtkuC9BSoxpVAO57YvSM/ORz6c6aP4ffADFbtePxvgBmBS7uslLq3oIYZFCFIgv0EINDKN+5iLwZJeGRAB3qPbR7eRk/8tunuPC57xgY5Vck/QF/VxA8C8vRmg2t82Dozf9XmGzAY/OawOhjeeNPlssgnW+Wx2qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=onvcdyFZ; arc=fail smtp.client-ip=40.93.194.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="onvcdyFZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmstEbLL4iqm0km922Zi0lJ9IQne+akBl5uC3FOYunxPxNJnxr2bPVhhAEW6oqf211fl/aZBGrx098L5mgdrmK9OvfnCy1ggkBvpIfdx2JyA0Z3V7RzalrZceQCb+bAbRsC5sjpjXvkGeeN6GmPr1A1op2kRIaF4cQT8G9n2vZSwBh4f+jowfTfKGtDmSiL7ZTlYQ8+bC7DCUB8qwp5Wwp2nzbqkEsGKA5tcTcY1OkFak7m1H0w19zA/6IAJiy93qALEhAirTFrGXDah6zUeAmX4IHV2YeE1B06bjAaeDpNcB1ZaXu0mP68ET50a6xy9nAV74h+Qk6Q04N0WJ3W+Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hssKKQeVe0LxYHRFyb8FdpbyrJGvmZJp+7cT0GzSOg=;
 b=xuj1WCPBySFVoQ4Il6odGvFnEle/mlnENokjlCozDDQDfi8T7F1AxKKOxhfKQzHRMRphq08xok7xHeGCdfaK5GdEGgWWot86175zMPlSwWolpUxcccdG1i/VBb9c/Oj96Oj9OEgbCZgGW6nn/W/wDVIFnMidm127PNklcq52F4JiDSX70thYVJgRccR542JWgYuceyu/QxpXzwWieN2mAqqDgtFSOlSy8wAZJOdFOmTXm+qViLXZs8HfPi99URjZnFb7KnYg/9i0d/VeNY4/WOIh+Biagyy3gdgB/6Su16GS0SUWKzQ3RCxWvSoNLci4CvFS725dJj7mRj84zyZDww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hssKKQeVe0LxYHRFyb8FdpbyrJGvmZJp+7cT0GzSOg=;
 b=onvcdyFZ1ocyxsgEG4f4xBigPWcnWGM//b7uTz5zxGuO8QtntzkTZSkd/PS0zMxVJHgCPp9UX9SRVTVcXQby3RxQAoo2eq2ALQ96u6HVOoeHgjAxulNnou5ZGNlzayA3TQWmaXxCRbDAGBvf7S7n66kcFNbpDyEGVkGd6iHkUj9OyQ2lRkaQqE3smxMZGnA2NnVRalKgts9AR2NcRuHkQ35Vf+tXLlW+MEIhqEjim3oz+A5LQ54e8X0tZHExr9070C/L3GU8soYqcXjb8GIRpHUS6mUf9azJORpAoA/5jfyoL85PiEVsoLpe2xpD/ZHOXX7am6ls5ALpofVSy/bwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17) by CH3PR12MB8306.namprd12.prod.outlook.com
 (2603:10b6:610:12c::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 02:45:31 +0000
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688]) by CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 02:45:30 +0000
From: KobaK <kobak@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koba Ko <kobak@nvidia.com>
Subject: [PATCH v2] cxl/region: Validate partition index before array access
Date: Tue, 14 Apr 2026 10:45:27 +0800
Message-ID: <20260414024527.3399590-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0007.namprd21.prod.outlook.com
 (2603:10b6:a03:114::17) To CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHXPR12MB999244:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a917f6-886f-423a-2bac-08de99cfe4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G1pAwb8msdg4VrUcocIafkbVh7WpfG3FFlAALMRh7PbvHCq2FOjo8L9aPI5nLl8V8kDIkTnvLwllBamMwXxPAe2NeB01IFxExFlqN3+iMi3JzNIRFBgEipBJrI4g8Pk8mRAzVdKetHcbTRdF+HfjVCsS0ICnEeQAZgI4ihmDewwDFOz5iwPvg5x1pVJTK9Q3dQeJ1e8rFQFHdiIFs9+LhQf6AekHcza0DetVXMEgWHB7JABFuX92OPCH2ODBkrBASJrabDxotl1myhV3cYxqtgKR/x7UXguQoj5Rf4pzB7aN6EcrgihCotIaNW8wyhg4zspfpp+iqqjaQGWFqGPMfcQnuhjjtRauD8lrvj90i8jTglHcX2C9YprZEQQHn/F1TcgIOcggSC6NKEySEmdNsY8/MJftBX8u5FOgtIRFw8vJ22yzPwfgapEWP2OV/4GJ4YJtQZIvpuOCBSKB6KO/EChEqwk7D7JrLwbuvaNsj4CHeSoRoWQtj+j9fGOf8fvLn8gdYJwH8cah3o8ydk9jeZ68Hhx++GAKb9EPNRISDqMScWmsCV3FTYbkFGu306/re/00Bzn1QEwr6aMjPFbGITXpvZHhE63HCEk/bE2FgBS75qGV1+hVO9nsrAS3hGs2iyBjHpaUlYCtbVa5uZKeLLoQ6nTvgzDHTKSl5OvUYgfBex+dM8nHA0oeawWBtYAWwgAI7Z9eDjDCARn+U+eQcD5zdMDS8qaeG8SjILdqYXU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ujo43EfJUul5KkUyWWlp/sDL3miNFuV776mKyPqY5ukq1BMtAnvLKp00A2Q4?=
 =?us-ascii?Q?C8LIVfyj+jy862WsEkK0KU4kp6qGQTyk/KcpxyE9jaXXOmBE5wybnMQWGIjG?=
 =?us-ascii?Q?t864YLA7BdDIfukAASvUohpJnamZeEf8BTDc+as0yLJZ/VDTDuRZoft3D2x1?=
 =?us-ascii?Q?1ZfJrEF6BaryIxqy3Isi0+1eHUvP88uniUnij3N+FswdlsRyRuonYdBHsuKz?=
 =?us-ascii?Q?KHBSsi3va9kUYN1YeQZbTr6Um6/jME4u98V1XEeYGqS/KpAaeC5FPfSTRTgB?=
 =?us-ascii?Q?kqDQ7a5N3PVrQePaC5E/VlcQc1qGAdzpQ21BJkZleGM5B3IFE3F4ei15IJPB?=
 =?us-ascii?Q?eVUI04pi8+qbhyr3ZYXKqLI43l5JGlt4TuPZeSuxK7BGStgeL7Cn+Wh7KdW5?=
 =?us-ascii?Q?w36oEopYHGNN9q5aopMJUCsqAeFeO09N9Nl/AI8goD0GPhdl88V4Iw4euaZh?=
 =?us-ascii?Q?Iyiw7EoNNDzBj0OJAkoJ0iQw1U8RWzG+KV+kO5ZPdbAv6QkrtlyVQczABDcS?=
 =?us-ascii?Q?fu2jaxv974+7H4B6YeYLe0si0g2abLgYZ0EazvcGiP7hTo1j2OrZziJKqt0/?=
 =?us-ascii?Q?H7DjNVqqUW2JVDLGdLVJktUEf7lPzvJr/OMBSKKCpEPPBVHq1K7G74tI54Xh?=
 =?us-ascii?Q?ZNswYRe1uLgMkFJJ/OE7m6Bw60TW80tWcFqgIfe8zPEP9JPPeWm1/pxrRlAX?=
 =?us-ascii?Q?E/ys7UdU+WHLexZfjTrH+VZZ+BJ4yyKwVx+iA1VJQ4GjO4cDiiiE/lmd1gZC?=
 =?us-ascii?Q?szjHQRCRlVwt07pqPl1rfEZulzhN8PFmkwFNuD4cLj2cixLMvTihcIGECkNH?=
 =?us-ascii?Q?M3PBQbAvzfGb8MQ7o/hWYB+WAMVKrYpfEgmExqAbEUydA/42I4SpeEUyzYqT?=
 =?us-ascii?Q?E1KDap7QrLyonal2bfVWbIeOcp/B7+hDXW2HlJGg8J5+/IO5v7G+cW6LIeY1?=
 =?us-ascii?Q?gzWWey1dQp4kvequLShggqVX3Jsnx04HCpGVFPvmC880Rn+L8bu8JYfoEmmu?=
 =?us-ascii?Q?Qf8gYGruamC7l2PzqKfY99daEE9I6bFqX+FVNkMit0pAkDHtwXzEJ/WWKqSe?=
 =?us-ascii?Q?/G2LkzXE74hZ8m+DCh/OdglQo1OclDRSDD1N22mZBJXOAOv6WplZpVT9iaaL?=
 =?us-ascii?Q?s3wK1xzWUUw+JthRWe/UR65nJA7slM60BnRSOcrHIznPp2SnWenY95oRylbz?=
 =?us-ascii?Q?yb/DYVpCl3Y6p/MclV9GTIyc7S3ZgifRpj9UP5t0XDlFtX7y+mUSoXGTt9Vf?=
 =?us-ascii?Q?PUUCbxAJiGqLLXjRMsx17AD7IbdNNaDM1Go1oA9vIYNrtPX5Q0codQ3KnCFg?=
 =?us-ascii?Q?3O+9qf69xlClQYY1HkgXtoOjKxUAEBW9sTQHOu5veekjde1/UOF9A+wZB7Mg?=
 =?us-ascii?Q?dKaDzFMo0rMRACpRyJlnd0e+PmZ3cj8knlJyg7bM9t8dLm/dJK4vEAUt/NWt?=
 =?us-ascii?Q?u+zcYnwXgt/M4e/TxjFIHAA6tao9obxhOSRVfx13okdQeIq7no2DvgqpZRdN?=
 =?us-ascii?Q?KiRF/rfbT4ru4oMy6+wrvJbnwijWoEDAu0etXSDb9g6BDs3ZQlRl9lt7q0RN?=
 =?us-ascii?Q?lRDuynnaNvydPy1c9bJO3ADoG6AWIeV39jJ9Fl4qrjeoop+UkHk0tJYtXMPI?=
 =?us-ascii?Q?cdqBPKEDBCcPWsZ6LssXSpyDff9mymvods+U37PlGAvSADIao/xxq7k1Qn7A?=
 =?us-ascii?Q?f+Rx6X450HOFyQVFlC2hd8Rq+z1kgUy7BuKCxWrIh5n1yGD/SzmHaqzPLBmR?=
 =?us-ascii?Q?y+1CbYZh0g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a917f6-886f-423a-2bac-08de99cfe4c5
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 02:45:30.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4mIIgefXW7CxreDi7wOWMR9lwlA8SUvjoirO1Yszq5XFX0l6BeyC1hElHhNqdaBRkFjMDv+/3j14vyL4KtP0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

From: Koba Ko <kobak@nvidia.com>

construct_region() reads cxled->part and uses it to index
cxlds->part[] without checking for a negative value. If the
partition was never resolved, part remains at its initial value
of -1, causing an out-of-bounds array access.

Add a guard to return -EBUSY when part is negative.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Koba Ko <kobak@nvidia.com>
---
 drivers/cxl/core/region.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index edc267c6cf77..de749b54fd62 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3712,6 +3712,9 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
 	int rc, part = READ_ONCE(cxled->part);
 	struct cxl_region *cxlr;
 
+	if (part < 0)
+		return ERR_PTR(-EBUSY);
+
 	do {
 		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
 				       atomic_read(&cxlrd->region_id),
-- 
2.43.0

