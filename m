Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8369146D6B
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jan 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737730612; cv=none; b=T/CD8hKQzcaeIe5k+hayw+6Ox2RlmEFOVJ3IkD/E1hO2AwVr4QyHZHNxZccCdntNgwjXcPp9pbZ/vJXPIZEGF0nkE6lXtvYwGrqA8OSzZrNgSsszboqRq+DwfEvbnINr+wXaet8RTr/BZTAQKN4BMApRxoW3cTgFT6X3IOFFccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737730612; c=relaxed/simple;
	bh=/OLvcbM68cqcJDvtaoz050V8kYuHfX4cuBb01RNlK5g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKwdrf4iC38/8RJYWMlilmocmJYLgO6RysDiyc4+/R6nIfTWBsDrgZpYFzugOXmoW+5juSZ1/Nx5cZ6C3AKTTfsUWR4y7lRJA/d4NjjzFFXmgw7EkJfmmw3XlDB+YZWatrvPGV709ADQOaGnEU95aqi5waq5/JBO1JbNWPh91Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yfgp04QVVz6M4MZ;
	Fri, 24 Jan 2025 22:54:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 53D3D140114;
	Fri, 24 Jan 2025 22:56:47 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 24 Jan
 2025 15:56:46 +0100
Date: Fri, 24 Jan 2025 14:56:45 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <krish.reddy@samsung.com>,
	<vishak.g@samsung.com>, <a.manzanares@samsung.com>,
	<alok.rathore@samsung.com>, <s5.kumari@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations discovery commands (8.2.9.9.5.3)
Message-ID: <20250124145645.00005ba9@huawei.com>
In-Reply-To: <20250123050903.92336-2-vinayak.kh@samsung.com>
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
	<CGME20250123050912epcas5p2965fd6efa702030802a42c225f11f65b@epcas5p2.samsung.com>
	<20250123050903.92336-2-vinayak.kh@samsung.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 23 Jan 2025 10:39:02 +0530
Vinayak Holikatti <vinayak.kh@samsung.com> wrote:

Hi Vinayak,

Thanks for your patch!  Good to add support for this.

Various comments inline, but all fairly minor things.

thanks,

Jonathan


>     CXL spec 3.1 section 8.2.9.9.5.3 describes media operations commands.
>     CXL devices supports media operations discovery command.

Please don't indent the commit message. Maybe this is a side effect
of some tooling but definitely clean it up before sending a v2.

> 
> Signed-off-by: Vinayak Holikatti <vinayak.kh@samsung.com>
+CC linux-cxl to increase chance of review and let people know this
exists.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 130 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 128 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9c7ea5bc35..2315d07fb1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -87,8 +87,9 @@ enum {
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
>      SANITIZE    = 0x44,
> -        #define OVERWRITE     0x0
> -        #define SECURE_ERASE  0x1
> +        #define OVERWRITE        0x0
> +        #define SECURE_ERASE     0x1
> +        #define MEDIA_OPERATIONS 0x2

Trivial but I've given up trying to keep these aligned.
It's a fools game as the names get steadily longer.

As such better to just leave the existing pair alone.

>      PERSISTENT_MEM = 0x45,
>          #define GET_SECURITY_STATE     0x0
>      MEDIA_AND_POISON = 0x43,
> @@ -1721,6 +1722,127 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>      return CXL_MBOX_BG_STARTED;
>  }
>  
> +enum {
> +    MEDIA_OP_GENERAL  = 0x0,
I'd name them so the field id explicit.

MEDIA_OP_CLASS_GENERAL
etc

> +    MEDIA_OP_SANITIZE = 0x1,
> +    MEDIA_OP_CLASS_MAX,
No comma on terminating entry. We don't want it to be easy to add
stuff after it.

> +} MEDIA_OPERATION_CLASS;
The enum type is never used.  So might as well keep it anonymous
like we do for other enums in this file.

> +
> +enum {
> +    MEDIA_OP_SUB_DISCOVERY = 0x0,
This set of class and subcalss is similar to the enum you add
the MEDIA_OPERATIONS define to above.
I'd take a similar strategy with

enum {
    MEDIA_OP_CLASS_GENERAL = 0x0,
        #define MEDIA_OP_GEN_SUBC_DISCOVERY 0x0
    MEDIA_OP_CLASS_SANITIZE = 0x1,
        #define MEDIA_OP_SAN_SUBC_SANITIZE 0x0
        #define MEDIA_OP_SAN_SUBC_ZERO 0x1

or something like that.
}
> +    MEDIA_OP_SUB_SANITIZE = 0x0,
> +    MEDIA_OP_SUB_ZERO     = 0x1,
> +    MEDIA_OP_SUB_CLASS_MAX
No need for SUB_CLASS_MAX as you don't seem to use it.

> +} MEDIA_OPERATION_SUB_CLASS;
> +
> +struct media_op_supported_list_entry {
> +    uint8_t media_op_class;
> +    uint8_t media_op_subclass;
> +};
> +
> +struct media_op_discovery_out_pl {
> +    uint64_t dpa_range_granularity;
> +    uint16_t total_supported_operations;
> +    uint16_t num_of_supported_operations;
> +    struct media_op_supported_list_entry entry[0];
entry[] 

which is the c spec defined way to do variable length last elements.
The [0] was I think a weird extension that we have moved away from.

> +};

Not strictly necessary but I'd mark it packed as chances of future breakage
are high with a structure starting at byte 0xC.

> +
> +#define MAX_SUPPORTED_OPS 3
I'd avoid explicit define for this and just use ARRAY_SIZE() on the
array of structures to find out.

> +struct media_op_supported_list_entry media_op_matrix[MAX_SUPPORTED_OPS] = {

Use the defines above rather than the numeric values.
Then it's obvious what this is, also mark it static const.

static const struct media_op_supported_list_entry media_op_matrix[] =
    { MEDIA_OP_CLASS_GENERAL, MEDIA_OP_GEN_SUBC_DISCOVERY },
    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_SANITIZE },
    { MEDIA_OP_CLASS_SANITIZE, MEDIA_OP_SAN_SUBC_ZERO },
};

> +                                                            {0, 0},
> +                                                            {1, 0},
> +                                                            {1, 1} };
> +
> +static CXLRetCode cmd_media_operations(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    struct {
> +    uint8_t media_operation_class;
    struct {
        uint8_t media_operation_class;

etc for alignment.

> +    uint8_t media_operation_subclass;
> +    uint8_t rsvd[2];
> +    uint32_t dpa_range_count;
> +    union {
> +        struct {
> +            uint64_t starting_dpa;
> +            uint64_t length;
> +        } dpa_range_list[0];
[]

> +        struct {
> +            uint16_t start_index;
> +            uint16_t num_supported_ops;
> +        } discovery_osa;
> +    };

This is a little tricky as in theory you can have a variable number
of DPA Range List elements and then the operation specific arguments.

However, general always provides a range count of 0.  Also both sanitize
and zero have no osa elemetns.  Add a comment
about this so we don't think it looks wrong in future + do notice that
this approach doesn't generalize if a new operation allows dpa ranges
and operation specific parameters.


> +    } QEMU_PACKED *media_op_in_pl = (void *)payload_in;
> +
> +    uint8_t media_op_cl = media_op_in_pl->media_operation_class;
> +    uint8_t media_op_subclass = media_op_in_pl->media_operation_subclass;
> +    uint32_t dpa_range_count = media_op_in_pl->dpa_range_count;
> +
> +    if (len_in < sizeof(*media_op_in_pl)) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }

Test this before getting values to fill in media_op_cl local variables etc.
It's both logically correct and may constrain the compiler not to get too smart
if it can see enough to realize what len_in is.

> +
> +    switch (media_op_cl) {
> +    case MEDIA_OP_GENERAL:
> +        switch (media_op_subclass) {
> +        case MEDIA_OP_SUB_DISCOVERY:
Given there is only one element, maybe cleaner as
           if (media_op_subclass != MEDIA_OP_SUB_DISCOVERY) {
                return CXL_MBOX_UNSUPPORTED;
           }
AS reduces indent of the following, helping readability a litle.

> +            int count = 0;
> +            struct media_op_discovery_out_pl *media_out_pl =
> +                (void *)payload_out;
> +            int num_ops = media_op_in_pl->discovery_osa.num_supported_ops;
> +            int start_index = media_op_in_pl->discovery_osa.start_index;
> +
> +            /* As per spec CXL 3.1 8.2.9.9.5.3 dpa_range_count */
> +            /* should be zero for discovery sub class command */
Local style is multiline comment as
               /*
                * As per spec CXL 3.1...
                * should be zero...
                */

> +            if (dpa_range_count) {
> +                return CXL_MBOX_INVALID_INPUT;
> +            }
> +
> +            if ((start_index >= MEDIA_OP_CLASS_MAX) ||
> +                (num_ops > MAX_SUPPORTED_OPS)) {

Check here should be for num_ops + start_index > MAX_SUPPORTED OPS
Comparing start_index against MEDIA_OP_CLASS_MAX doesn't make sense to me
as I believe it's an index into the array of Class / subclass pairs not
the class array.


> +                return CXL_MBOX_INVALID_INPUT;
> +            }
> +
> +            media_out_pl->dpa_range_granularity = CXL_CAPACITY_MULTIPLIER;
> +            media_out_pl->total_supported_operations = MAX_SUPPORTED_OPS;
> +            if (num_ops > 0) {
> +                for (int i = start_index; i < MAX_SUPPORTED_OPS; i++) {
> +                    media_out_pl->entry[count].media_op_class =
> +                            media_op_matrix[i].media_op_class;
> +                    media_out_pl->entry[count].media_op_subclass =
> +                            media_op_matrix[i].media_op_subclass;
> +                    count++;
> +                    if (count == num_ops) {
> +                        goto disc_out;

break should be enough and removes need for goto and label.

> +                    }
> +                }
> +            }
> +disc_out:
> +            media_out_pl->num_of_supported_operations = count;
> +            *len_out = sizeof(struct media_op_discovery_out_pl) +
> +            (sizeof(struct media_op_supported_list_entry) * count);

indent this line.

> +            break;
I'd
        return CXL_MBOX_SUCCESS;

> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
> +        break;
then this break isn't needed.
> +    case MEDIA_OP_SANITIZE:
> +        switch (media_op_subclass) {
> +
No blank line here yet.
> +        default:
> +            return CXL_MBOX_UNSUPPORTED;
> +        }
Similar. Return in all paths so no break.
> +        break;
> +    default:
> +        return CXL_MBOX_UNSUPPORTED;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
>                                           size_t len_in,
> @@ -2864,6 +2986,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>           CXL_MBOX_SECURITY_STATE_CHANGE |
>           CXL_MBOX_BACKGROUND_OPERATION |
>           CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
> +    [SANITIZE][MEDIA_OPERATIONS] = { "MEDIA_OPERATIONS", cmd_media_operations,
> +        ~0,
> +        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
> +         CXL_MBOX_BACKGROUND_OPERATION)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>          cmd_get_security_state, 0, 0 },
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",

