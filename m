Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2110.outbound.protection.outlook.com [40.107.92.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9F715356D
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168199; cv=fail; b=iJtSjn+pwSLW/QSuiKVsClABGyXCM1QgAaotNyxcAbY7yx2Sq/A6SaRq00QIzF4d5eA8CGnBJtH7JrlRo1AHp5YGMC6OausId+8tX7vBU+n4wdXuIufqhKWNuYpt6y+JkU2xte/nVQtTVr6MMchhttq5OPdzgYQoIJgi9j6AwmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168199; c=relaxed/simple;
	bh=QRD8DpJIZbFXMWO2UT032UCxORW2DTuDIKSHkllMvgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XrouLQSaCzrnTlNx9um8kkVRaNHZDwVMad8RmWToHGiBzKVGUhxF06TXd8SjhsRj75ibXyGnsoxmMltVJIWkACsbdW6NvleACxekPVQgiuy6O5nfezoCimZBd+wFJw5EqZ4YHj8lUxmlfTq/B/8BMo4xDiMSda2AoDFlUj4cvhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=SMUjzFmk; arc=fail smtp.client-ip=40.107.92.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="SMUjzFmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YD0/zecN2V1bza9N/le2fPyFHQ3XdjfU9ZU8AQpe7E4QrSDoJ6b0Ypjw7cb46n98xhwfUm4FKcyVWEYZq/QZ8d6pBwRY86anQj0OaSBHGY5fz++tZBo2XvoH/bRrqgMSU5Yfmh3fbth/w6ZWcO/jrxO6oXYBIzD6CVpdPShQsaP+3E0kd9wZQUnKk7jLnLkv+jThu+HJlHAIA2flfZIx11UHZ5LsKLjFXwBJI2jCld5LqYRz9SCxWF5tzCJZGT/IzVXXX8KeH6O7mm5w5jmjQAGROvQx6RB5CEBv3CwVYOBFJRC8R7bRBpwDeHp+fP4K79Iuy8/kL9ZxbO45Yfq41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smwbvzX7anve6jTeAPCg5domEyI1RXDHeWlsQq0MtuE=;
 b=K31a/b3lJiLoXwoxoE2c8FQ/4ZUDLtewOiJ3E+BDo1K5nTPsr75w2CsR+TICpXyAG6a/KpRwuZaQwJrpkfA4pUgyLSpvfsNa9w3crIHGTs96WwGLaNhMKiCdS4STu/zfS3Mwxp7sD633jUX5DjUaqJbl3UI25+3xg0ru6FuN0IQgZsTPO4g+rD4jnmEYmYo6tQWJxvVss4p345ssBqA8KOf23UbJEYrX+VJ8k9WpuJiiWuekossPlngr4oo3hQnJtQq2sP5FTtPId1oP+/3eqqPIL5TmTyamMTZYk/rgcZ/4hefyqFvtLMMSUZ2AIfkAGJrtMgEnKp0D6pPw54VaXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smwbvzX7anve6jTeAPCg5domEyI1RXDHeWlsQq0MtuE=;
 b=SMUjzFmkifh4g4hdTJ+YyV/Hj4w86FMhsyxVtgD/01v9M6Rh71fqciN3Cm434QdUwErrwiADVh/ShOCvL6l6tLC4LphHAOv5N3cFwvKLD5z20rK7SbQBfs96LCRIGJ+CbSSsTQYtrOjpJoS+mRFdkWdMcYPBuIcwIehXkhUegZY=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM4PR17MB6390.namprd17.prod.outlook.com (2603:10b6:8:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 18:16:34 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 18:16:34 +0000
Date: Wed, 3 Apr 2024 14:16:25 -0400
From: Gregory Price <gregory.price@memverge.com>
To: nifan.cxl@gmail.com
Cc: qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <Zg2c+YauNGqhFfTW@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325190339.696686-10-nifan.cxl@gmail.com>
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM4PR17MB6390:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rGdy65jQ2Y5RZqf/PvyO+/1o56irkFPHjNWuTapW8XGSA25EmQThBoJnDgKOZwsUuXrvlJaX6aroH3XQXJIvHqjETZeutjQp93BwCNh2FCzUSM3TsfM9LUdrsTYBDhtKr1t4k3pFfI17LkqgtWfLxsJND6qYIcqiEmGc+rbgJLpTcqEoMzQ10iSFHPJx9mIBQJMmzzaYwRxxkVt2lYZMx1esoIqJZ2W5F8Ya20LTxFiIYj057J0oXzX3S0Xs8Zu139KNipnmymfbKpyJm4VeevrrgpeaEcBv0jHa5JWVIW9wlm3mtFk34sO0Kt+kT57SGH37baJlLKhj1LR+4wpNR9rStBPdYbQR4HVMhcg0dHSN95cuTVOl/dqJ01yvA4o5MwcOdEdy8Yla8/tykiyuPQNuQaOXG/z00kWf0MWqPRYaxblisXsLYsl6cytFlFxBUcgI42AYhJm1hUSBfwxl5mMxR2uv25gzhY9iCd3BmI/VMDnUoeROhDfT429x6VTTYek9liK+mTPnw6ORvPVgPgFri7nQMk11BfHNXjrQdhPoWD5cHccmKB/fQf7IA9c+PEyMRp5TGxdqo3otBkz4gle9PiT74toqMf6Be5RUxD47fMQazQMhyL2x0cTfgmcGMblS7H6RvlSeqdseYlwkKjZnOIi7j1v5KeXXsxNls8s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gv8Ijp7OX4S+1wl/AGemhFhsAkUFwCoDOPbUb604upz75p6yv7kcph+SOhEC?=
 =?us-ascii?Q?aNcpCttqOJlFwufuUfacW9yCssueRltJS8oXTro7QWbdNCaqKSM28U0o/Gic?=
 =?us-ascii?Q?ZSQtepGmse/5gEgcp6gaJYiE8IVmoS/dkSdAJGM16GMyOEhTfy9HcJoGYAJU?=
 =?us-ascii?Q?0MWVGjd9uiESRgAoFpFomlDr37xImTN+JRVOl9MWpmKB/FCmeV+lderpQWOq?=
 =?us-ascii?Q?58dEzTa9+OykBNxSMd1xVdMexXOCwS8S+PCpB8ZCiaSusyFz7d6mi82bAyr+?=
 =?us-ascii?Q?KdvOArf1tvry7LwLce/dv2TYVoNynqkRFeiYAdWyxNU1cxcogjlkt2q07yE7?=
 =?us-ascii?Q?5LLmeFwLuWlZtmzsjYo0Q85Du0kOlC3QYcqWhZ26vpMYtEa4ts72ngk9eqch?=
 =?us-ascii?Q?iCxfsNfipMaRdMoZu6r9hjw440CjpV2m+CsC+iulnkU4VC6JZbrCNG6BLP8H?=
 =?us-ascii?Q?KGEhD/otXXW+WEX251JX5pG4J75IltbHykg4YQ2KaTk+Snyo6wHvj8lyt9mf?=
 =?us-ascii?Q?/R1nOFgQ/03xx4tGoQ4gaPQDZlXgDNirOBynZ8gkKGr+6PJ41SU7DLUeuEu/?=
 =?us-ascii?Q?6wb3j+w/UKw+Pws2ox5FojsJoP9O88L9AZj6X88w/qeb9QGZcra1+qLB8oW6?=
 =?us-ascii?Q?G+Mtt++5aRS6oOQlRpXAq0ufsJunU5yqyVOhun2rLWNeW8Yf8yztOQMK+NWX?=
 =?us-ascii?Q?kXAkB4379IAFacOVcXt48NBwzXtFgmXnCVSRLCouG0nw/hI80+DNVN7k0NNh?=
 =?us-ascii?Q?92mPaPJFUut78bjQf/FczaiVF3h5dn6ZWGPg9OT4UDOqy9J9gPnzCSxzEfuy?=
 =?us-ascii?Q?t8qOqw5IxlJbKGhbPggB1NVJPTfAiuPxA7J8Cmia5ybinj1BzczIc8BAtzbf?=
 =?us-ascii?Q?LSE5Aieqtoy4A8pWWXnCb/SC9gltYLUp845/n5dkLTas1TYx/XwqWoqd/UOe?=
 =?us-ascii?Q?ZCV1u7BuljO+prX4dBpqaWOsdG9onCaixoQq5DpQt6Sdnv6p4wgrKGNpHe/e?=
 =?us-ascii?Q?ng7epnRDz+GVNjHRaLTKmrnacazTo7yy16ICdmGSn7DtUtDpW/BY5tEGj62v?=
 =?us-ascii?Q?wMAyks6s671oO57NpGBYfPaYXlYrMnw1XpYa/AtbsGyA0gnrb0j3Myv3HRJo?=
 =?us-ascii?Q?CiN+YwXHiTi4aOlVvUKyY8dtK2eJfaInVLbtV4crkl7wnQ+pRcwyW7WiAmcB?=
 =?us-ascii?Q?I6WShxjkej3UU/GiAtRDyC366DdqCyE3VE8GSxV0u+DvD/+4LJrR4UQ1hsr8?=
 =?us-ascii?Q?6HpBd926dRfadpGS+vvUvpjolc7Cy/4AJIhnrtLaXe35611d0W/yFDPevBKa?=
 =?us-ascii?Q?Hmqx4yPLZKhasMGTwBptU5ncbPcuRaiuORG7gMIhPQwaEylTOpQmZV7U2Nze?=
 =?us-ascii?Q?qGIVanpIgvQWSC4As+DRU5KD+FBIXiG9YMTnIYo2icVIEgnWdgls4XL/CAuD?=
 =?us-ascii?Q?kszqX7HjJ9Zoo/hwCMw0WA4AUXe9eFdb/+wgwqQ5OJQs6b5E/iRAo39oscWa?=
 =?us-ascii?Q?TBjlePppARDGZWDqdjzIKhF+qE7Y6PQSXjWojX5Fr1n26cap6YDvnUb62SDE?=
 =?us-ascii?Q?I6AAaC49pep9hvNMn8pns8Vnwa21dkwugHHbNv7YDnTA3gYHoL6ZQt3EfmaG?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebbc053-8c00-4cb5-1a83-08dc540a31dc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 18:16:34.4758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XBpdDm0yE/qK8T5Q7gur65lmeSxB/ivZZSy9KafFeI6dj/Br2lKFsMJgfF9/3vwFcjszOVfmyUiNId6IJAI4/lmJib4b6ZNQU/pgpFvTSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR17MB6390

On Mon, Mar 25, 2024 at 12:02:27PM -0700, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> To simulate FM functionalities for initiating Dynamic Capacity Add
> (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in CXL spec
> r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP interfaces to issue
> add/release dynamic capacity extents requests.
> 
... snip 
> +
> +/*
> + * The main function to process dynamic capacity event. Currently DC extents
> + * add/release requests are processed.
> + */
> +static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> +                                             CXLDCEventType type, uint16_t hid,
> +                                             uint8_t rid,
> +                                             CXLDCExtentRecordList *records,
> +                                             Error **errp)
> +{
... snip 
> +    /* Sanity check and count the extents */
> +    list = records;
> +    while (list) {
> +        offset = list->value->offset;
> +        len = list->value->len;
> +        dpa = offset + dcd->dc.regions[rid].base;
> +
> +        if (len == 0) {
> +            error_setg(errp, "extent with 0 length is not allowed");
> +            return;
> +        }
> +
> +        if (offset % block_size || len % block_size) {
> +            error_setg(errp, "dpa or len is not aligned to region block size");
> +            return;
> +        }
> +
> +        if (offset + len > dcd->dc.regions[rid].len) {
> +            error_setg(errp, "extent range is beyond the region end");
> +            return;
> +        }
> +
> +        /* No duplicate or overlapped extents are allowed */
> +        if (test_any_bits_set(blk_bitmap, offset / block_size,
> +                              len / block_size)) {
> +            error_setg(errp, "duplicate or overlapped extents are detected");
> +            return;
> +        }
> +        bitmap_set(blk_bitmap, offset / block_size, len / block_size);
> +
> +        num_extents++;

I think num_extents is always equal to the length of the list, otherwise
this code will return with error.

Nitpick:
This can be moved to the bottom w/ `list = list->next` to express that a
little more clearly.

> +        if (type == DC_EVENT_RELEASE_CAPACITY) {
> +            if (cxl_extents_overlaps_dpa_range(&dcd->dc.extents_pending,
> +                                               dpa, len)) {
> +                error_setg(errp,
> +                           "cannot release extent with pending DPA range");
> +                return;
> +            }
> +            if (!cxl_extents_contains_dpa_range(&dcd->dc.extents,
> +                                                dpa, len)) {
> +                error_setg(errp,
> +                           "cannot release extent with non-existing DPA range");
> +                return;
> +            }
> +        }
> +        list = list->next;
> +    }
> +
> +    if (num_extents == 0) {

Since num_extents is always the length of the list, this is equivalent to
`if (!records)` prior to the while loop. Makes it a little more clear that:

1. There must be at least 1 extent
2. All extents must be valid for the command to be serviced.

> +        error_setg(errp, "no valid extents to send to process");
> +        return;
> +    }
> +

I'm looking at adding the MHD extensions around this point, e.g.:

/* If MHD cannot allocate requested extents, the cmd fails */
if (type == DC_EVENT_ADD_CAPACITY && dcd->mhd_dcd_extents_allocate &&
    num_extents != dcd->mhd_dcd_extents_allocate(...))
	return;

where mhd_dcd_extents_allocate checks the MHD block bitmap and tags
for correctness (shared // no double-allocations, etc). On success,
it garuantees proper ownership.

the release path would then be done in the release response path from
the host, as opposed to the release event injection.

Do you see any issues with that flow?

> +    /* Create extent list for event being passed to host */
> +    i = 0;
> +    list = records;
> +    extents = g_new0(CXLDCExtentRaw, num_extents);
> +    while (list) {
> +        offset = list->value->offset;
> +        len = list->value->len;
> +        dpa = dcd->dc.regions[rid].base + offset;
> +
> +        extents[i].start_dpa = dpa;
> +        extents[i].len = len;
> +        memset(extents[i].tag, 0, 0x10);
> +        extents[i].shared_seq = 0;
> +        list = list->next;
> +        i++;
> +    }
> +
> +    /*
> +     * CXL r3.1 section 8.2.9.2.1.6: Dynamic Capacity Event Record
> +     *
> +     * All Dynamic Capacity event records shall set the Event Record Severity
> +     * field in the Common Event Record Format to Informational Event. All
> +     * Dynamic Capacity related events shall be logged in the Dynamic Capacity
> +     * Event Log.
> +     */
> +    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
> +                            cxl_device_get_timestamp(&dcd->cxl_dstate));
> +
> +    dCap.type = type;
> +    /* FIXME: for now, validity flag is cleared */
> +    dCap.validity_flags = 0;
> +    stw_le_p(&dCap.host_id, hid);
> +    /* only valid for DC_REGION_CONFIG_UPDATED event */
> +    dCap.updated_region_id = 0;
> +    /*
> +     * FIXME: for now, the "More" flag is cleared as there is only one
> +     * extent associating with each record and tag-based release is
> +     * not supported.
> +     */
> +    dCap.flags = 0;
> +    for (i = 0; i < num_extents; i++) {
> +        memcpy(&dCap.dynamic_capacity_extent, &extents[i],
> +               sizeof(CXLDCExtentRaw));
> +
> +        if (type == DC_EVENT_ADD_CAPACITY) {
> +            cxl_insert_extent_to_extent_list(&dcd->dc.extents_pending,
> +                                             extents[i].start_dpa,
> +                                             extents[i].len,
> +                                             extents[i].tag,
> +                                             extents[i].shared_seq);
> +        }
> +
> +        if (cxl_event_insert(&dcd->cxl_dstate, enc_log,
> +                             (CXLEventRecordRaw *)&dCap)) {

Pardon if I missed a prior discussion about this, but what happens to
pending events in the scenario where cxl_event_insert fails?

~Gregory
