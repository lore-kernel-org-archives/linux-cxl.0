Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A99222565;
	Sun, 28 Sep 2025 10:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759054609; cv=pass; b=ZGPP19lW2kEEdYXYmL7A8unzAPhb7d07BIXrDu61ERhwR+Hp+UNL3MaOVQuCyBRb0u7wcKqMc3sr9l6iS4NqksiOdgPHx8epzM7MvHiiXz0jUgsMAqnpBN+u6Uctq5LXlUO1ayrieF0qcDeRKfOETAIJfUOvR5QwzwBV6qkKzj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759054609; c=relaxed/simple;
	bh=+H9VdnqNSyhVBmdblY183rLbEM9XSxY6Yd0hQeZcY3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auukTdoixOyJ1BhVHCoX62aDeI/sxMx8XxxpACEZRhEAoWiywgPGaobovKFGpfsyt7rHLdSm/U7ufqtO9FdGQArvA/unYNdOblqqVzAOVxhf4RjTqcugzClHdVQPXD2INo1OwWoGY/Pze0oiX2UWm3o99bXyN4YA9sNwArW//1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=cyJhuzYr; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="cyJhuzYr"
ARC-Seal: i=1; a=rsa-sha256; t=1759054597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=jJYFM+neAQWXQB2cGsa059A37UafrOrAeVZiuV4CE7zRdQfPN0vFAT9bn9hfd34xGwacSV24TyBIY4dGjG9/nlvmiSYYfy2yMVStu+fS9POfqZO/ZJ19UBkJ5VKUbdWighpX5F5KvwZjMTVTrDgmEezZqBrbyLwZKHmnykzr26Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759054597; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VpJ42JwGW7UCIUZCk56ZiPKjeQZx31ky9Sdds9RDDE0=; 
	b=LmEctG8cjRs0pjToGljveqgUQjyAm53JRwp4Bynq+kqA/SFHV+PnbK8EhypZtIWTR9W8lHwNQOI6MrITMSklfISjkA1ASwmTZpPawv1d9KI9CYi9rP4+T/YoDJw7teWlwIMtj3ApJkFHgIi9VzS9KUEO6oHtz/mbARZHM4BeokA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759054597;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=VpJ42JwGW7UCIUZCk56ZiPKjeQZx31ky9Sdds9RDDE0=;
	b=cyJhuzYrD67LRh8aX9QiOmLyspEpZHV4K8rHewSUYLqgEDrAhqwxuUnkyLMzF3or
	Q1FyNzw5ehTe4RxXnDhjW7n9JRo7pd69JePZz+dBC0RUg+P8ohk9sDLAl3XbnSgTczO
	60n1CPuN7hU50lWLvF43JyjCFTb7fr9lrJcCKQeQ=
Received: by mx.zohomail.com with SMTPS id 1759054595484277.04724689880084;
	Sun, 28 Sep 2025 03:16:35 -0700 (PDT)
Message-ID: <b07ec317-e916-49bf-bec1-1f954c186457@zohomail.com>
Date: Sun, 28 Sep 2025 18:16:34 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cxl/port: Avoid missing port component registers
 setup
To: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250928082703.377604-1-ming.li@zohomail.com>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250928082703.377604-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr0801122797bed76955fafd33bcb314ec0000a1f87f7218a27dec8bca7e40cc5a976ec6e4309f9e97185078:zu08011227f1469caad17054085a11c72b0000c9ad2e567683e470eb3660837c9ed7f54c2cf6ff34e9d17320:rf0801122dc8cef12522f375a8397b5b9c0000da168a4a7fb79ab958201027d79c1fc903aeb25c84496bf9696c00847b6e74:ZohoMail
X-ZohoMailClient: External

Please ignore this version.
If cxl_port_setup_regs() fails, should remove dport from port->dports. send out v2 to fix it.

Ming

On 9/28/2025 4:27 PM, Li Ming wrote:
> port->nr_dports is used to represent how many dports added to the cxl
> port, it will increase in add_dport() when a new dport is being added to
> the cxl port, but it will not be reduced when a dport is removed from
> the cxl port.
>
> Currently, when the first dport is added to a cxl port, it will trigger
> component registers setup on the cxl port, the implementation is using
> port->nr_dports to confirm if the dport is the first dport.
>
> A corner case here is that adding dport could fail after port->nr_dports
> updating and before checking port->nr_dports for component registers
> setup. If the failure happens during the first dport attaching, it will
> cause that CXL subsystem has not chance to execute component registers
> setup for the cxl port. the failure flow like below:
>
> port->nr_dports = 0
> dport 1 adding to the port:
> 	add_dport()	# port->nr_dports: 1
> 	failed on devm_add_action_or_reset() or sysfs_create_link()
> 	return error	# port->nr_dports: 1
> 	no chance for component registers setup execution
> dport 2 adding to the port:
> 	add_dport()	# port->nr_dports: 2
> 	no failure
> 	skip component registers setup because of port->nr_dports is 2
>
> The solution here is that moving component registers setup closer to
> add_dport(), so if add_dport() is executed correctly for the first
> dport, component registers setup on the port will be executed
> immediately after that.
>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> base-commit: 46037455cbb748c5e85071c95f2244e81986eb58 cxl/next
> ---
>  drivers/cxl/core/port.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index d5f71eb1ade8..e25f326acd7a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1182,6 +1182,18 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> +	/*
> +	 * Setup port register if this is the first dport showed up. Having
> +	 * a dport also means that there is at least 1 active link.
> +	 */
> +	if (port->nr_dports == 1 &&
> +	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +		port->component_reg_phys = CXL_RESOURCE_NONE;
> +	}
> +
>  	get_device(dport_dev);
>  	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
>  	if (rc)
> @@ -1200,18 +1212,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> -	/*
> -	 * Setup port register if this is the first dport showed up. Having
> -	 * a dport also means that there is at least 1 active link.
> -	 */
> -	if (port->nr_dports == 1 &&
> -	    port->component_reg_phys != CXL_RESOURCE_NONE) {
> -		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> -		if (rc)
> -			return ERR_PTR(rc);
> -		port->component_reg_phys = CXL_RESOURCE_NONE;
> -	}
> -
>  	return dport;
>  }
>  


